require 'rails_helper'

RSpec.describe 'postcode_checker/new.html.erb', type: :view do
  it 'renders the postcode_checker new view and form' do
    render

    assert_select 'h1', 'Check Postcode', 1
    assert_select 'div.field', 1 do
      assert_select 'label[for=?]', 'postcode_checker_postcode', 1
      assert_select 'input[type=?]', 'text', 1
    end

    assert_select 'div.actions', 1 do
      assert_select 'input[type=?][value=?]', 'submit', 'Check Postcode'
    end
  end
end
