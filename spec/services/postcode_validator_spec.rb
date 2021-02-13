# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Services::PostcodeValidator, type: :model do
  let(:valid_postcode) { 'SE1 7QD' }
  let(:invalid_postcode) { 'invalid' }

  describe '.valid_postcode?' do
    it 'returns true when validating a valid postcode' do
      expect(described_class.valid_postcode?(valid_postcode)).to be true
    end

    it 'returns false when validating an invalid postcode' do
      expect(described_class.valid_postcode?(invalid_postcode)).to be false
    end
  end

  describe '.valid_format?' do
    it 'should return true for given postcode with the correct format' do
      expect(described_class.valid_format?(valid_postcode)).to be true
    end

    it 'should return false for a postcode with the wrong format' do
      expect(described_class.valid_format?(invalid_postcode)).to be false
    end
  end

  describe '.shape_postcode' do
    it 'should return an identical copy of a valid postcode' do
      expect(described_class.shape_postcode(valid_postcode)).to eq(valid_postcode)
    end
    it 'should return a format-corrected copy of given valid postcode' do
      postcode = valid_postcode.gsub(' ', '').downcase
      expect(described_class.shape_postcode(postcode)).to eq(valid_postcode)
    end
  end
end