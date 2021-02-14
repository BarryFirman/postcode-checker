# frozen_string_literal: true

require 'net/http'
require 'uk_postcode'
module Services
  class PostcodesIoClient

    INVALID_POSTCODE_MSG = 'Error: Postcode Not Found - %<postcode>s'
    UNREACHABLE_ERROR_MSG = 'System Error: Unable to check this postcode at this time.'

    def initialize(postcode:, url: 'https://api.postcodes.io', uri: '/postcodes/')
      @postcode = Services::PostcodeValidator.shape_postcode postcode
      @url = url.freeze
      @uri = uri.freeze
    end

    def call_api
      valid_format = Services::PostcodeValidator.valid_format? @postcode
      unless valid_format
        return return_statement(status: 'failed',
                                message: format(INVALID_POSTCODE_MSG.to_s, postcode: @postcode),
                                data: '')
      end
      uri = URI(@url)
      uri.path = "#{@uri}#{uri_postcode}"
      begin
        return_statement status: 'success',
                         message: '',
                         data: JSON.parse(Net::HTTP.get_response(uri).body, symbolize_names: true)
      rescue SocketError
        return_statement status: 'failed', message: UNREACHABLE_ERROR_MSG, data: ''
      end
    end

    private

    def uri_postcode
      @postcode.to_s.gsub(' ', '')
    end

    def return_statement(status:, message:, data:)
      { status: status, message: message, data: data }
    end

    def ensure_postcode_format
      return_statement(status: 'failed', message: 'Incorrect Postcode Format', data: '') unless @postcode.valid?
    end
  end
end
