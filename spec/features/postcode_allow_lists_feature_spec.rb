#frozen_string_literal: true

require 'rails_helper'

RSpec.describe PostcodeAllowList, type: :feature do
  let(:pal) { create(:postcode_allow_list, :valid) }
  let(:valid_postcode) { 'IP13 0SR' }
  let(:invalid_postcode) { 'invalid' }

  scenario 'User creates new PasswordAllowList entry with valid data.' do
    visit postcode_allow_lists_url
    click_link 'Create New Allowed Postcode'
    expect(page).to have_text('New Postcode')
    fill_in 'Postcode', with: valid_postcode
    click_button 'Create Postcode allow list'
    expect(page).to have_text('Post Code successfully created.')
  end

  scenario 'User fails to create new PasswordAllowList entry with invalid data.' do
    visit postcode_allow_lists_url
    click_link 'Create New Allowed Postcode'
    expect(page).to have_text('New Postcode')
    fill_in 'Postcode', with: invalid_postcode
    click_button 'Create Postcode allow list'
    expect(page).to have_text('Postcode invalid postcode format')
  end

  scenario 'User edits PasswordAllowList entry with valid data' do
    pal
    visit postcode_allow_lists_url
    click_link 'Edit'
    fill_in 'Postcode', with: valid_postcode
    click_button 'Update Postcode allow list'
    expect(page).to have_text('Postcode successfully updated.')
  end

  scenario 'User edits PasswordAllowList entry with invalid data' do
    pal
    visit postcode_allow_lists_url
    click_link 'Edit'
    fill_in 'Postcode', with: invalid_postcode
    click_button 'Update Postcode allow list'
    expect(page).to have_text('Postcode invalid postcode format')
  end

  scenario 'User edits PasswordAllowList entry with duplicate data' do
    expect do
      pal
      PostcodeAllowList.create! postcode: 'SH24 1AB'
    end.to change(PostcodeAllowList, :count).by(2)
    visit postcode_allow_lists_url
    click_link href: "/postcode_allow_lists/#{PostcodeAllowList.last.id}/edit"
    fill_in 'Postcode', with: 'SH24 1AA'
    click_button 'Update Postcode allow list'
    expect(page).to have_text('Postcode has already been taken')
  end

  scenario 'User deletes PasswordAllowList entry' do
    list = pal
    visit postcode_allow_lists_url
    expect(page).to have_text(list.postcode)
    click_link 'Delete'
    expect(page).to_not have_text(list.postcode)

  end
end
