# frozen_string_literal: true

require 'net/http'
require 'uk_postcode'
module Services
  class PostcodesIoClient

    INVALID_POSTCODE_FORMAT_MSG = 'Incorrect Postcode Format'
    UNREACHABLE_ERROR_MSG = 'Checking Service Currently Unavailable'

    attr_reader :postcode

    def initialize(postcode:, url: 'https://api.postcodes.io', uri: '/postcodes/',
                   allowed_lsoas: %w[Southwark Lambeth])
      @postcode = UKPostcode.parse(postcode)
      @url = url.freeze
      @uri = uri.freeze
      @allowed_lsoas = allowed_lsoas.freeze
    end

    def call_api
      return return_statement(status: 'failed', message: INVALID_POSTCODE_FORMAT_MSG, data: '') unless @postcode.valid?

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
      postcode.to_s.gsub(' ', '')
    end

    def return_statement(status:, message:, data:)
      { status: status, message: message, data: data }
    end

    def ensure_postcode_format
      return_statement(status: 'failed', message: 'Incorrect Postcode Format', data: '') unless @postcode.valid?
    end
  end
end
