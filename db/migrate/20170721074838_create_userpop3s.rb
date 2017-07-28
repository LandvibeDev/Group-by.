class CreateUserpop3s < ActiveRecord::Migration[5.1]
  def change
    create_table :userpop3s do |t|
      t.belongs_to :user
      t.string :title
      t.string :email
      t.string :password
      t.integer :port
      t.string :pop3

      t.timestamps
    end
  end
end
