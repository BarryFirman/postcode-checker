# frozen_string_literal: true

module Services
  class PostcodeChecker
    ALLOWED_LSOAS = %w[Southwark Lambeth].freeze

    def initialize(postcode:)
      @postcode = postcode
    end

    def check_postcode
      return return_statement(status: 'success', message: '', in_area: true) if on_allowed_list?

      pic = Services::PostcodesIoClient.new(postcode: @postcode)
      response = pic.call_api
      return_statement(status: response[:status],
                       message: response[:message],
                       in_area: in_area(response))
    end

    private

    def return_statement(status:, message:, in_area:)
      { status: status, message: message, in_area: in_area }
    end

    def shape_data(response)
      lsoa_data = nil

      unless response[:data].empty?
        lsoa_data = response[:data][:result][:lsoa] if response[:data][:result][:lsoa].present?
      end

      lsoa_data
    end

    def on_allowed_list?
      !PostcodeAllowList.where(postcode: @postcode).empty?
    end

    def in_area(response)
      lsoa = shape_data(response)
      return nil if lsoa.nil?

      ALLOWED_LSOAS.include?(lsoa[0, lsoa.rindex(" ")])
    end
  end
end
