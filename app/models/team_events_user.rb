class TeamEventsUser < ApplicationRecord
  belongs_to :team_event
  belongs_to :user
end
