class CreateContents < ActiveRecord::Migration[5.1]
  def change
    create_table :contents do |t|
      t.belongs_to :group
      t.string :title
      t.text :content
      t.datetime :start_date
      t.datetime :end_date

      t.timestamps
    end
  end
end
