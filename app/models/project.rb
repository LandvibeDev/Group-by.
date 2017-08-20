class Project < ApplicationRecord

  has_many :team_events
  has_and_belongs_to_many :users, -> { distinct }
end
