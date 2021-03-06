# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Pages Routing', type: :routing do
  context 'used routes' do
    it 'routes to #home' do
      expect(get: '/').to route_to('postcode_checker#new')
    end
  end
end