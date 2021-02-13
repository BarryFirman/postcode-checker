require 'rails_helper'

RSpec.describe 'PostcodeChecker', type: :request do
  let(:in_area_postcode) { { postcode: 'SE1 7ED' } }
  let(:invalid_postcode) { { postcode: 'invalidpostcode' } }
  let(:allowed_postcode) { { postcode: 'SH24 1AA' } }
  let(:out_area_postcode) { { postcode: 'IP13 0SR' } }
  let(:postcode_allow_list) { create(:postcode_allow_list, :valid) }

  describe 'POST /check' do
    it 'should return a successful response for #check' do
      post check_postcode_url, params: { postcode_checker: in_area_postcode }
      expect(subject).to redirect_to(root_path)
    end

    it 'should return successful with invalid params' do
      post check_postcode_url params: in_area_postcode
      expect(subject).to redirect_to(root_path)

    end

  end

  describe 'responses' do
    context 'valid data' do
      it 'should return success for allowed postcode' do
        postcode_allow_list.save!
        post check_postcode_url, params: { postcode_checker: { postcode: postcode_allow_list.postcode } }
        expect(subject).to redirect_to(root_path)
      end

      it 'should return successful response for out of area postcode' do
        post check_postcode_url, params: { postcode_checker: out_area_postcode }
        expect(subject).to redirect_to(root_path)
      end
    end

    context 'invalid data' do
      it 'should return a successful response for blank param' do
        post check_postcode_url, params: { postcode_checker: '' }
        expect(subject).to redirect_to(root_path)
      end

      it 'should return a successful response for nil params' do
        post check_postcode_url, params: { postcode_checker: nil }
        expect(subject).to redirect_to(root_path)
      end

      it 'should return a successful response for blank postcode' do
        post check_postcode_url, params: { postcode_checker: { postcode: '' } }
        expect(subject).to redirect_to(root_path)
      end

      it 'should return a successful response for nil postcode' do
        post check_postcode_url, params: { postcode_checker: { postcode: nil } }
        expect(subject).to redirect_to(root_path)
      end

      it 'should return success for invalid postcode' do
        post check_postcode_url, params: { postcode_checker: invalid_postcode }
        expect(subject).to redirect_to(root_path)
      end
    end
  end
end
