# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PostcodeAllowListsController, type: :routing do
  describe 'routing' do
    context 'used routes' do
      it 'routes to #index' do
        expect(get: 'postcode_allow_lists').to route_to('postcode_allow_lists#index')
      end

      it 'routes to #new' do
        expect(get: 'postcode_allow_lists/new').to route_to('postcode_allow_lists#new')
      end

      it 'routes to #create' do
        expect(post: 'postcode_allow_lists').to route_to('postcode_allow_lists#create')
      end

      it 'routes to #destroy' do
        expect(delete: 'postcode_allow_lists/1').to route_to('postcode_allow_lists#destroy', id: '1')
      end
    end

    context 'unused routes' do
      it 'does not route to #show' do
        expect(get: 'postcode_allow_lists/1').to_not route_to('postcode_allow_lists#show', id: '1')
      end

      it 'does not route to# edit' do
        expect(get: 'postcode_allow_lists/1/edit').to_not route_to('postcode_allow_lists#edit', id: '1')
      end

      it 'does not route to #update - put' do
        expect(put: 'postcode_allow_lists/1').to_not route_to('postcode_allow_lists#update', id: '1')
      end

      it 'does not route to #update - patch' do
        expect(patch: 'postcode_allow_lists/1').to_not route_to('postcode_allow_lists#', id: '1')
      end
    end

  end

end
