class Project < ApplicationRecord

  has_many :events
  has_and_belongs_to_many :users, -> { distinct }
end
