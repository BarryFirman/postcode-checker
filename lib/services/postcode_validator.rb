# frozen_string_literal: true

module Services
  class PostcodeValidator
    class << self
      def valid_postcode?(postcode)
        pic = Services::PostcodesIoClient.new postcode: postcode
        response = pic.call_api
        response[:status] == 'success'
      end

      def valid_format?(postcode)
        UKPostcode.parse(postcode).valid?
      end

      def shape_postcode(postcode)
        UKPostcode.parse(postcode).to_s
      end
    end
  end
end
