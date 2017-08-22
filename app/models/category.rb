class Category < ApplicationRecord
  has_many :group_categories
  has_many  :user_categories
end
