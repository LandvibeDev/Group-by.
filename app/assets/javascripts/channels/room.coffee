$('#tlqkf').on 'click', ->
  App.cable.connect();


App.room = App.cable.subscriptions.create "RoomChannel",
  connected: ->
    console.log('connected');
# Called when the subscription is ready for use on the server

  disconnected: ->
    console.log('disconnected');
# Called when the subscription has been terminated by the server

  received: (data) ->
    console.log('recevied');
# Called when there's incoming data on the websocket for this channel

  speak: ->
    @perform 'speak'
#console.log('speak');



