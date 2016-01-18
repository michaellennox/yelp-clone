class AddDescriptionToRestaurants < ActiveRecord::Migration
  def change
    add_column :restaurants, :description, :string
    add_column :restaurants, :text, :string
  end
end
