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
    it 'should not be valid with duplicate postcode' do
      valid_postcode.save
      postcode = PostcodeAllowList.last.postcode
      expect(PostcodeAllowList.new(postcode: postcode)).to_not be_valid
    end

    context 'entering postcode in lower or mixed case' do
      it 'should validate against uppercase entries' do
        valid_postcode.save
        postcode = PostcodeAllowList.last.postcode
        expect(PostcodeAllowList.new(postcode: postcode.downcase)).to_not be_valid
      end

      it 'should be changed to uppercase before being saved.' do
        postcode = valid_postcode.postcode
        valid_postcode.postcode.downcase
        valid_postcode.save
        expect(PostcodeAllowList.last.postcode).to eq(postcode)
      end
    end
    context 'updating a postcode' do
      it 'should update the postcode' do
        valid_postcode.save
        pal = PostcodeAllowList.first
        new_postcode = 'IP13 0SR'
        pal.update postcode: new_postcode

        expect(pal.reload.postcode).to eq(new_postcode)
      end
    end
  end

  context 'invalid postcode' do
    it 'should not be valid' do
      expect(invalid_postcode).to_not be_valid
    end
    it 'should not save the postcode' do
      expect { invalid_postcode.save }.to change { PostcodeAllowList.count }.by(0)
    end

    context 'updating' do
      it 'should not update an entry with an invalid postcode' do
        valid_postcode.save
        pal = PostcodeAllowList.first
        before_update_postcode = pal.postcode
        new_postcode = 'invalid'
        pal.update postcode: new_postcode

        expect(pal.reload.postcode).to eq(before_update_postcode)
      end

      it 'should not update an entry with a duplicate postcode' do
        valid_postcode.save
        pal = PostcodeAllowList.first
        pal_postcode = pal.postcode
        second_pal_postcode = 'IP13 0SR'
        expect do
          @second_pal = PostcodeAllowList.create! postcode: second_pal_postcode
        end.to change(PostcodeAllowList, :count).by(1)

        @second_pal.update postcode: pal_postcode

        expect(@second_pal.reload.postcode).to eq(second_pal_postcode)
      end

      it 'should not update an entry with a duplicate postcode in another case' do
        valid_postcode.save
        pal = PostcodeAllowList.first
        pal_postcode = pal.postcode
        second_pal_postcode = 'ip13 0sr'
        expect do
          @second_pal = PostcodeAllowList.create! postcode: second_pal_postcode
        end.to change(PostcodeAllowList, :count).by(1)

        @second_pal.update postcode: pal_postcode

      end
    end
  end
end
