class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.belongs_to :content
      t.string :user_name
      t.string :comment

      t.timestamps
    end
  end
end
