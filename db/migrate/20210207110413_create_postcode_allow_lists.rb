class CreatePostcodeAllowLists < ActiveRecord::Migration[6.1]
  def change
    create_table :postcode_allow_lists do |t|
      t.string :postcode, unique: true

      t.timestamps
    end
  end
end
