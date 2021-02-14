require 'rails_helper'

RSpec.describe "PostcodeAllowLists", type: :request do

  let(:pal) { create(:postcode_allow_list, :valid) }
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

    describe 'GET /edit' do
      it 'is a successful response for edit' do
        get edit_postcode_allow_list_url pal
        expect(response).to be_successful
      end
    end

    describe '/update' do
      let(:new_valid_postcode) { 'IP13 0SR' }
      let(:new_invalid_postcode) { 'invalid '}

      context 'using PATCH'do
        context 'with valid parameters' do
          it 'updates the given entry' do
            list = pal
            patch postcode_allow_list_url(list), params: { postcode_allow_list: { postcode: new_valid_postcode } }
            expect(response).to redirect_to(postcode_allow_lists_url)
            expect(list.reload.postcode).to eq(new_valid_postcode)
          end
        end
        context 'with invalid parameters' do
          it 'does not update given entry' do
            list = pal
            before_password = list.postcode
            patch postcode_allow_list_url(list), params: { postcode_allow_list: { postcode: new_invalid_postcode } }
            expect(response).to render_template(:edit)
            expect(list.reload.postcode).to eq(before_password)
          end
        end
      end

      context 'using PUT' do
        context 'with valid parameters' do
          it 'updates the given entry' do
            list = pal
            put postcode_allow_list_url(list), params: { postcode_allow_list: { postcode: new_valid_postcode } }
            expect(response).to redirect_to(postcode_allow_lists_url)
            expect(list.reload.postcode).to eq(new_valid_postcode)
          end
        end
        context 'with invalid parameters' do
          it 'does not update given entry' do
            list = pal
            before_password = list.postcode
            put postcode_allow_list_url(list), params: { postcode_allow_list: { postcode: new_invalid_postcode } }
            expect(response).to render_template(:edit)
            expect(list.reload.postcode).to eq(before_password)
          end
        end
      end
      end

    describe 'DELETE /destroy' do
      context 'with valid data' do
        it 'destroys the requested PostcodeAllowList' do
          postcode_allow_list = PostcodeAllowList.create! valid_attributes
          expect do
            delete postcode_allow_list_url(postcode_allow_list)
          end.to change(PostcodeAllowList, :count).by(-1)
        end

        it 'redirects to #index' do
          postcode_allow_list = PostcodeAllowList.create! valid_attributes
          delete postcode_allow_list_url(postcode_allow_list)
          expect(response).to redirect_to(postcode_allow_lists_url)
        end
      end

      context 'with invalid data' do
        it 'does not destroy a PostcodeAllowList record' do
          postcode_allow_list = PostcodeAllowList.create!(valid_attributes)
          expect do
            delete postcode_allow_list_url(postcode_allow_list.id + 1)
          end.to change(PostcodeAllowList, :count).by(0)
        end

        it 'redirects to #index' do
          postcode_allow_list = PostcodeAllowList.create!(valid_attributes)
          delete postcode_allow_list_url(postcode_allow_list.id + 1)
          expect(response).to redirect_to(postcode_allow_lists_url)
        end
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
