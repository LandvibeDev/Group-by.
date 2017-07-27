class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.string :title
      t.string :start
      t.string :end

      t.timestamps
    end
  end
end
