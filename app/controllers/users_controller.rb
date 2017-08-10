class UsersController < ApplicationController
  # GET /groups
  def inviteShow
    @invites = Invite.where(:invite_user => params[:user_id])
  end

  # GET /groups
  def all
    @user = User.find(current_user.id)
    @mygroups = @user.groups.all

    @usergroups = GroupsUser.all

    @groups = Group.all
  end

  def delete_push
    Push.destroy(params[:id])

    render json: current_user.pushs.count
  end
end