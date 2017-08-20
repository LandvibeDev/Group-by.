class CreateInvites < ActiveRecord::Migration[5.1]
  def change
    create_table :invites do |t|
      t.belongs_to :user
      t.integer :invite_user
      t.integer :invite_project

      t.timestamps
    end
  end
end
