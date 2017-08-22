$(document).on('turbolinks:load', function() {
    submitNewMessage();
});

var p_id = $("[data-project]").data().project;

App['room' + p_id] = App.cable.subscriptions.create({channel: 'RoomChannel', room: p_id}, {
    connected: function() {
        return console.log('connected!');
    },
    disconnected: function() {
        return console.log('disconnected');
    },
    received: function(data) {
        var c_user = $('[data-project=\'' + this.projectId + '\']').attr("data-user");
        if(data.user_id == c_user) {
            $('[data-project=\'' + this.projectId + '\']').append('<div class="message clearfix">' +
                '<div class="chat-bubble from-me">' +
                data.message +
                '</div>' +
                '</div>');
        }else{
            $('[data-project=\'' + this.projectId + '\']').append('<div class="message clearfix">' +
                '<div class="chat-bubble from-them">' +
                data.message +
                '</div>' +
                '</div>');
        }
        return console.log('recevied');
    },
    setProjectId: function(projectId) {
        return this.projectId = projectId;
    }
});

function submitNewMessage(){
    $('#type_message').keydown(function(event) {
        if (event.keyCode == 13) {
            var msg = event.target.value
            if(msg != "") {
                var projectId = $("[data-project]").data().project
                App['room' + projectId].setProjectId(projectId)
                App['room' + projectId].send({message: msg, project_id: projectId})
                event.target.value = ''
                event.preventDefault()
            }
            return false;
        }
    });
}