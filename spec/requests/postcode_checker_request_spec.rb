require 'rails_helper'

RSpec.describe 'PostcodeChecker', type: :request do
  let(:in_area_postcode) { { postcode: 'SE1 7ED' } }
  let(:invalid_postcode) { { postcode: 'invalidpostcode' } }
  let(:allowed_postcode) { { postcode: 'SH24 1AA' } }
  let(:out_area_postcode) { { postcode: 'IP13 0SR' } }
  let(:postcode_allow_list) { create(:postcode_allow_list, :valid) }

  describe 'POST /check' do
    it 'is a successful response for check' do
      post check_postcode_url, params: { postcode_checker: in_area_postcode }
      expect(response).to be_successful
    end
  end

  describe 'responses' do
    context 'valid data' do
      it 'should return success for allowed postcode.' do
        post check_postcode_url, params: { postcode_checker: allowed_postcode }
        expect(response).to be_successful
      end

      it 'should return success for out of area postcode'do
        post check_postcode_url, params: { postcode_checker: out_area_postcode }
        expect(response).to be_successful
      end
    end

    context 'invalid data' do
      it 'should return success for invalid postcode' do
        post check_postcode_url, params: { postcode_checker: invalid_postcode }
        expect(response).to be_successful
      end
    end
  end
end
