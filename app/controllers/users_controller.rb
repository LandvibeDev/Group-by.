class UsersController < ApplicationController
  # GET /groups
  def inviteShow
    @user = User.find(current_user.id)
    @invites = Invite.where(:invite_user => @user.id)
  end

  # GET /groups
  def all
    @user = User.find(current_user.id)
    @mygroups = @user.groups.all

    @usergroups = GroupsUser.all

    @groups = Group.all
  end

  # GET /edit
  def edit
    @user = User.find(params[:id])

  end

  # GET /search
  def search

    @user = User.find(params[:user_id])

    # enrolled groups
    @mygroups = @user.groups.all.where("title LIKE ?" , "%#{params[:word]}%")
    # not enroolled groups
    @groups = Group.where("title LIKE ?" , "%#{params[:word]}%")

    @result = {:mygroups=> @mygroups,:groups=> @groups}

    render :json => @result
  end

  def delete_push
    Push.destroy(params[:id])

    render json: current_user.pushs.count
  end

end