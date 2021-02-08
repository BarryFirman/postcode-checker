require 'rails_helper'

RSpec.describe 'PostcodeChecker', type: :request do
  let(:in_area_postcode) { { postcode: 'SE1 7ED' } }
  let(:invalid_postcode) { { postcode: 'invalidpostcode' } }
  let(:allowed_postcode) { { postcode: 'SH24 1AA' } }
  let(:out_area_postcode) { { postcode: 'IP13 0SR' } }
  let(:postcode_allow_list) { create(:postcode_allow_list, :valid) }

  describe 'POST /check' do
    it 'is a successful response for check' do
      post check_post_code_url, params: { postcode_checker: valid_postcode }
      expect(response).to be_successful
    end
  end

  describe 'responses' do
    context 'valid data' do
      it 'should return success and postcode is in the area' do

      end

      it 'should return success for allowed postcode.' do

      end

      it 'should return postcode is not in the area' do

      end
    end

    context 'invalid data' do
      it 'should return failure for unreachable service' do

      end

      it 'should return failure for invalid postcode' do

      end
    end
  end
end
