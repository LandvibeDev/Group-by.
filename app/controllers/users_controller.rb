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

  def search

    @user = User.find(params[:user_id])

    # enrolled groups
    @mygroups = @user.groups.all.where("title LIKE ?" , "%#{params[:word]}%")
    # not enroolled groups
    @groups = Group.where("title LIKE ?" , "%#{params[:word]}%")
    # users
    @users = User.where("email LIKE ? AND id != ?" , "%#{params[:word]}%" , params[:user_id])

    @result = {:users=> @users,:mygroups=> @mygroups,:groups=> @groups}

    render :json => @result
  end

  def delete_push
    Push.destroy(params[:id])

    render json: current_user.pushs.count
  end
end