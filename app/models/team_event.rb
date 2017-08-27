class TeamEvent < ApplicationRecord

  belongs_to :project

  has_many :team_events_user
  has_many :users, :through => :team_events_users
end
