class CreateGroupCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :group_categories do |t|
      t.belongs_to  :group, index: true, uniq: true
      t.belongs_to  :category, index: true, uniq: true

    end
  end
end
