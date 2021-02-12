#frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Postcode Checker', type: feature do
  scenario 'User checks postcode with valid postcode that is in the area' do
    visit root_url
    fill_in 'Postcode', with: 'SE1 7QD'
    VCR.use_cassette('postcodes_io_valid_postcode') do
      click_button 'Check Postcode'
    end
    expect(page).to have_text('We can service area: SE1 7QD')
  end

  scenario 'User checks postcode with valid postcode that is out of the area' do
    visit root_url
    fill_in 'Postcode', with: 'IP13 0SR'
    VCR.use_cassette('postcodes_io_postcode_out_of_area') do
      click_button 'Check Postcode'
    end
    expect(page).to have_text('We cannot service area: IP13 0SR')
  end

  scenario 'User checks postcode with invalid postcode' do
    visit root_url
    fill_in 'Postcode', with: 'INVALID'
    VCR.use_cassette('postcodes_io_postcode_out_of_area') do
      click_button 'Check Postcode'
    end
    expect(page).to have_text(Services::PostcodesIoClient::INVALID_POSTCODE_FORMAT_MSG)
  end

  scenario 'User hits submit with no postcode entry' do
    visit root_url
    fill_in 'Postcode', with: ''
    VCR.use_cassette('postcodes_io_postcode_out_of_area') do
      click_button 'Check Postcode'
    end
    expect(page).to have_text('Error: Please ensure you have entered a postcode.')
  end



end
