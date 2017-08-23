class AddProfileToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :userProfile, :string
  end
end
