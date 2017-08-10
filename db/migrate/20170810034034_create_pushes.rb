class CreatePushes < ActiveRecord::Migration[5.1]
  def change
    create_table :pushes do |t|
      t.belongs_to :user
      t.string :message
      t.integer :group_id

      t.timestamps
    end
  end
end
