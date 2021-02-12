# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PostcodeCheckerController, type: :routing do
  it 'routes to #check' do
    expect(post: 'check_postcode').to route_to('postcode_checker#check')
  end
end
