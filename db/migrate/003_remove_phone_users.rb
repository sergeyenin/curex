class RemovePhoneUsers < ActiveRecord::Migration
  def self.up
    remove_column :users, :phone
  end

  def self.down
    #not neccessary
  end
end
