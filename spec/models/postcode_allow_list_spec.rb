# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PostcodeAllowList, type: :model do
  let(:valid_postcode) { build(:postcode_allow_list, :valid) }
  let(:invalid_postcode) { build(:postcode_allow_list, :invalid) }

  context 'valid postcode' do
    it 'should be valid' do
      expect(valid_postcode).to be_valid
    end
    it 'should save the postcode ' do
      expect { valid_postcode.save }.to change { PostcodeAllowList.count }.by(1)
    end
    it 'should destroy the valid postcode' do
      valid_postcode.save
      postcode = PostcodeAllowList.last
      expect { postcode.destroy }.to change { PostcodeAllowList.count }.by(-1)
    end
  end

  context 'invalid postcode' do
    it 'should not be valid' do
      expect(invalid_postcode).to_not be_valid
    end
    it 'should not save the postcode' do
      expect { invalid_postcode.save }.to change { PostcodeAllowList.count }.by(0)
    end
  end
end
