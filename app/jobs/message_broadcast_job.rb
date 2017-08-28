class MessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform(message)
    # Do something later

    ActionCable.server.broadcast("room-#{message.project_id}:messages", {message: message.content, project_id: message.project_id, user_id: message.user_id, user_name: User.find(message.user_id).name ,user_img: User.find(message.user_id).userProfile.thumb.url})
  end

  # private
  # def render_message(message)
  #   ApplicationController.renderer.render(partial: 'messages/message', locals: { message: message })
  # end
end
