require 'rails_helper'

RSpec.describe "Pages", type: :request do

  describe "GET /home" do
    it "is a successful response for home" do
      get root_url
      expect(response).to be_successful
    end
  end

end
