class CreateListings < ActiveRecord::Migration
  def self.up
    create_table :listings do |t|
      t.integer :user_id
      t.string :source_amount
      t.string :source_type
      t.string :rate
      t.string :target_amount
      t.string :target_type
      t.string :remarks

      t.timestamps
    end
  end

  def self.down
    drop_table :listings
  end
end
