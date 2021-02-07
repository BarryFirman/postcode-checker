require 'rails_helper'

RSpec.describe "PostcodeAllowLists", type: :request do
  let(:valid_attributes) { { postcode: 'SE1 7QD' } }
  let(:invalid_attributes) { { postcode: 'invalidpostcode' } }

  describe 'GET /index' do
    it 'is a successful response for index' do
      get postcode_allow_lists_url
      expect(response).to be_successful
    end
  end

  describe 'GET /new' do
    it 'is a successful response for new' do
      get new_postcode_allow_list_url
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates new postcode' do
        expect do
          post postcode_allow_lists_url, params: { postcode_allow_list: valid_attributes }
        end.to change(PostcodeAllowList, :count).by(1)
      end

      it 'redirects to #index' do
        post postcode_allow_lists_url, params: { postcode_allow_list: valid_attributes }
        expect(response).to redirect_to(postcode_allow_lists_url)
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new postcode' do
        expect do
          post postcode_allow_lists_url, params: { postcode_allow_list: invalid_attributes }
        end.to change(PostcodeAllowList, :count).by(0)
      end

      it 'is successful' do
        post postcode_allow_lists_url, params: { postcode_allow_list: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end
end
