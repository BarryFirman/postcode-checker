require 'rails_helper'

RSpec.describe 'postcode_allow_lists/new.html.erb', type: :view do
  before(:each) do
    assign(:postcode_allow_list, PostcodeAllowList.new)
  end

  it 'renders all required elements on new page' do
    render

    assert_select 'h1', 'New Postcode', 1
    assert_select 'label[for=?]', 'postcode_allow_list_postcode', 'Postcode', 1
    assert_select 'input[type=?]', 'text', 1
    assert_select 'div.actions', 1 do
      assert_select 'input[type=?][name=?]', 'submit', 'commit'
    end
    assert_select 'a[href=?]', '/postcode_allow_lists', 'Back', 1

  end
end