class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.belongs_to :user
      t.string :title
      t.text :content
      t.datetime :start_date
      t.datetime :end_date
      t.integer :selected_id

      t.timestamps
    end
  end
end
