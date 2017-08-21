class CreateMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :messages do |t|
      t.string :content
      t.belongs_to :project

      t.timestamps
    end
  end
end
