class CreateInvites < ActiveRecord::Migration[5.1]
  def change
    create_table :invites do |t|
      t.belongs_to :user
      t.integer :invite_user
      t.string :invite_project
      t.string :invite_user_email
      t.string :invite_project_title

      t.timestamps
    end
  end
end
