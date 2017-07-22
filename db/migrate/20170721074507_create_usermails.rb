class CreateUsermails < ActiveRecord::Migration[5.1]
  def change
    create_table :usermails do |t|
      t.belongs_to :userpop3
      t.string :subject
      t.text :content
      t.string :date
      t.string :from
      t.string :to

      t.timestamps
    end
  end
end
