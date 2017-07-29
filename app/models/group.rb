class Group < ApplicationRecord

  has_many :contents
  has_and_belongs_to_many :users
end
