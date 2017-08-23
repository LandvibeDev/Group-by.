class Category < ApplicationRecord
  has_many :group_categories
  has_many  :user_categories

  has_many :linked_groups, through: :group_categories, source: :group

end
