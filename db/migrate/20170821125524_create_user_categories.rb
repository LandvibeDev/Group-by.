class CreateUserCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :user_categories do |t|
      t.belongs_to  :user, index: true, uniq: true
      t.belongs_to  :category, index: true, uniq: true

    end
  end
end
