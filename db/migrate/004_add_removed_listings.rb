class AddRemovedListings < ActiveRecord::Migration
  def self.up
    add_column :listings, :removed, :boolean, :default=>false
  end

  def self.down
    #not neccessary
  end

end