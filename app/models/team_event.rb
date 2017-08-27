class TeamEvent < ApplicationRecord

  mount_uploader :teamEventImage, TeamEventImageUploader
  mount_uploader :teamEventFile, TeamEventFileUploader

  belongs_to :project

  has_many :team_events_user
  has_many :users, :through => :team_events_users
end
