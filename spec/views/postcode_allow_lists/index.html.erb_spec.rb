require 'rails_helper'

RSpec.describe 'postcode_allow_lists/index.html.erb', type: :view do
  before(:each) do
    assign(:postcode_allow_lists, [
      PostcodeAllowList.create!(postcode: 'SH24 1AA'),
      PostcodeAllowList.create!(postcode: 'SH24 1AB')
    ])
  end
  it 'renders all required elements on index page' do
    render
    assert_select 'h1', 'Allowed Postcodes', 1
    assert_select 'p', 1 do
      assert_select 'a[href=?]', '/postcode_allow_lists/new', 1
    end
    assert_select 'table', 1 do
      assert_select 'tr' do
        assert_select 'td', 'SH24 1AA', 1
        assert_select 'td' do
          assert_select 'a[href=?]', "/postcode_allow_lists/#{PostcodeAllowList.first.id}/edit"
        end
        assert_select 'td' do
          assert_select 'a[href=?]', "/postcode_allow_lists/#{PostcodeAllowList.first.id}"
        end
      end
      assert_select 'tr' do
        assert_select 'td', 'SH24 1AB', 1
        assert_select 'td' do
          assert_select 'a[href=?]', "/postcode_allow_lists/#{PostcodeAllowList.second.id}/edit"
        end
        assert_select 'td' do
          assert_select 'a[href=?]', "/postcode_allow_lists/#{PostcodeAllowList.second.id}"
        end
      end
    end
  end
end
