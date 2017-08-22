class RoomChannel < ApplicationCable::Channel
  def subscribed
    stream_from "room-#{params['room']}:messages"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def receive(data)
    @project = Project.find(data['project_id'])
    @message = @project.messages.create! content: data['message'], user_id: current_user.id
  end
end
