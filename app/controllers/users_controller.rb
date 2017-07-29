class UsersController < ApplicationController
  # GET /groups
  def inviteShow
    @invites = Invite.where(:invite_user => params[:user_id])
  end
end