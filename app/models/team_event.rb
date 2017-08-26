class TeamEvent < ApplicationRecord

  mount_uploader :teamEventImage, TeamEventImageUploader
  mount_uploader :teamEventFile, TeamEventFileUploader

  belongs_to :project
  has_and_belongs_to_many :users, -> { distinct }
end
