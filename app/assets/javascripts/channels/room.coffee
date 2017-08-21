App.room = App.cable.subscriptions.create "RoomChannel",
  connected: ->
    console.log('connected');
# Called when the subscription is ready for use on the server

  disconnected: ->
    console.log('disconnected');
# Called when the subscription has been terminated by the server

  received: (data) ->
    $('#messages').append data['message']
    $('#messages').append '<br>'
    console.log('recevied');
# Called when there's incoming data on the websocket for this channel

  speak: (message)->
    @perform 'speak', message: message

  $(document).on 'keypress', '[data-behavior~=room_speaker]', (event) ->
    if event.keyCode is 13 # return/enter= send
      App.room.speak event.target.value
      event.target.value = ''
      event.preventDefault()



