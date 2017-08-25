class CreatePushes < ActiveRecord::Migration[5.1]
  def change
    create_table :pushes do |t|
      t.belongs_to :user
      t.string :message
      t.integer :pusher_id
      t.integer :push_num #1: create_group_content 2:project_invite 3: project_edited

      t.timestamps
    end
  end
end
