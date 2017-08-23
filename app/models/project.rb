class Project < ApplicationRecord

  has_many :team_events
  has_many :messages
  has_many :projects_users
  has_many :users , :through => :projects_users
end
