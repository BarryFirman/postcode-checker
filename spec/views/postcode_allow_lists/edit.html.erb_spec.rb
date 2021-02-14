require 'rails_helper'

RSpec.describe 'postcode_allow_lists/edit.html.erb', type: :view do
  before(:each) do
    assign(:postcode_allow_list, PostcodeAllowList.create!(postcode: 'SH24 1AA'))
  end

  it 'renders all required elements on edit page' do
    render

    assert_select 'h1', 'Edit Postcode', 1
    assert_select 'label[for=?]', 'postcode_allow_list_postcode', 'Postcode', 1
    assert_select 'input[type=?]', 'text', 1
    assert_select 'div.actions', 1 do
      assert_select 'input[type=?][name=?]', 'submit', 'commit'
    end
    assert_select 'a[href=?]', '/postcode_allow_lists', 'Back', 1

  end
end
