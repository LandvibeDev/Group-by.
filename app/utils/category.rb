
class Category < ActiveRecord::Base
  enum status:  [:category1 , :category2]
end