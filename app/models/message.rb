class Message < ApplicationRecord
  belongs_to :project

  after_create_commit { MessageBroadcastJob.perform_later self }
end
