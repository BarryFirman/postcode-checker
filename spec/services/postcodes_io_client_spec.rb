# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Services::PostcodesIoClient, type: :model do

  let(:valid_postcode_allow_list) { build(:postcode_allow_list, :valid) }
  let(:valid_postcode) { described_class.new(postcode: 'SE1 7QD') }
  let(:invalid_postcode) { described_class.new(postcode: 'invalid') }
  let(:allowed_postcode) { described_class.new(postcode: valid_postcode_allow_list.postcode) }
  let(:api_down) { described_class.new(postcode: valid_postcode_allow_list.postcode, url: 'https://postcodes') }


  context 'valid postcode data' do
    it 'should return success for valid postcode.' do
      VCR.use_cassette('postcodes_io_valid_postcode') do
        response = valid_postcode.call_api
        expect(response[:status]).to eq('success')
        expect(response[:message]).to be_empty
        expect(response[:data][:result][:lsoa]).to start_with('Southwark')
      end
    end
  end

  context 'invalid postcode data' do
    it 'should return postcode format error' do
      VCR.use_cassette('postcodes_io_invalid_postcode.yml') do
        response = invalid_postcode.call_api
        expect(response[:status]).to eq('failed')
        expect(response[:message]).to eq(Services::PostcodesIoClient::INVALID_POSTCODE_FORMAT_MSG)
        expect(response[:data]).to be_empty
      end
    end
  end

  context 'unable to reach external api' do
    it 'should return failed status' do
      response = api_down.call_api
      expect(response[:status]).to eq('failed')
      expect(response[:message]).to eq(Services::PostcodesIoClient::UNREACHABLE_ERROR_MSG)
      expect(response[:data]).to be_empty
    end
  end
end
