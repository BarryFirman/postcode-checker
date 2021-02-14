# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Services::PostcodeChecker, type: :model do
  let(:valid_postcode_allow_list) { build(:postcode_allow_list, :valid) }
  let(:valid_postcode) { described_class.new(postcode: 'SE1 7QD') }
  let(:out_of_area) { described_class.new(postcode: 'IP13 0SR') }
  let(:invalid_postcode) { described_class.new(postcode: 'invalid') }
  let(:allowed_postcode) { described_class.new(postcode: valid_postcode_allow_list.postcode) }


  context 'valid postcode data' do
    it 'should return success for valid postcode.' do
      VCR.use_cassette('postcodes_io_valid_postcode') do
        response = valid_postcode.check_postcode
        expect(response).to eq({ status: 'success', message: '', in_area: true })
      end
    end

    it 'should return success for allow-listed postcode' do
      valid_postcode_allow_list.save
      postcode = PostcodeAllowList.last.postcode
      pc = described_class.new(postcode: postcode)
      response = pc.check_postcode
      expect(response).to eq({ status: 'success', message: '', in_area: true })
    end

    it 'should return postcode is not in the area' do
      VCR.use_cassette('postcodes_io_postcode_out_of_area') do
        response = out_of_area.check_postcode
        expect(response).to eq({ status: 'success', message: '', in_area: false })
      end
    end
  end

  context 'invalid postcode data' do
    it 'should return failure for invalid postcode' do
      VCR.use_cassette('postcodes_io_invalid_postcode') do
        response = invalid_postcode.check_postcode
        message = format(Services::PostcodesIoClient::INVALID_POSTCODE_MSG.to_s, postcode: 'invalid')
        expect(response).to eq({ status: 'failed',
                                 message: message,
                                 in_area: nil })
      end
    end
  end
end
