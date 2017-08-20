class AddGroupCoverToGroup < ActiveRecord::Migration[5.1]
  def change
    add_column :groups, :groupCover, :string
  end
end
