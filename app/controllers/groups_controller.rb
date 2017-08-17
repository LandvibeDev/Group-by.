class GroupsController < ApplicationController
  before_action :set_group, only: [:show, :edit, :update, :destroy]

  # GET /groups
  # GET /groups.json
  def index
    @user = User.find(current_user.id)
    @groups = @user.groups.all
  end

  # GET /groups/1
  # GET /groups/1.json
  def show
    @users = User.all
    @group = Group.find(params[:id])
    @contents = @group.contents.all

    @usergroups = GroupsUser.all
  end

  # GET /groups/new
  def new
    @group = Group.new
    @user = User.all
  end

  # GET /groups
  def inviteCreate
    @users = User.all
    @group = Group.find(params[:group_id])

    @user = User.find(current_user.id)
    @invite = @user.invites.new(invite_user: params[:user_id], invite_group: params[:group_id])
    @invite.save

    redirect_to user_group_invite_path(current_user.id, params[:group_id])
  end

  # GET /groups
  def invite
    @users = User.all
    @group = Group.find(params[:group_id])

    @usergroups = GroupsUser.all
  end

  # GET /groups/1/edit
  def edit
  end

  # POST /groups
  # POST /groups.json
  def create
    @user = User.find(current_user.id)
    @group = Group.new(group_params)

    @group.title = params[:title]
    @group.description = params[:description]

    respond_to do |format|
      if @group.save
        @user.groups << @group
        format.html { redirect_to user_group_path(current_user.id, @group.id) }
        format.json { render :show, status: :created, location: @group }
      else
        format.html { render :new }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # UPDATE /groups/join/1
  def join
    @user = User.find(params[:user_id])
    @group = Group.find(params[:group_id])

    @invite = Invite.where(:invite_group => params[:group_id], :invite_user => params[:user_id])
    @invite.delete_all

    respond_to do |format|
      if @group.save
        @user.groups << @group
        format.html { redirect_to user_group_path(current_user.id, params[:group_id])}
        format.json { render :show, status: :created, location: @group }
      else
        format.html { render :new }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /groups/1
  # PATCH/PUT /groups/1.json
  def update
    @user = User.find(current_user.id)
    @group = @user.groups.find(params[:id])
    @group.title = params[:title]
    @group.description = params[:description]

    respond_to do |format|
      if @group.update(title: params[:title], description: params[:description])
        format.html { redirect_to user_group_path(current_user.id, @group.id) }
        format.json { render :show, status: :ok, location: @group }
      else
        format.html { render :edit }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /groups/1
  # DELETE /groups/1.json
  def destroy
    @group.destroy
    respond_to do |format|
      format.html { redirect_to groups_url, notice: 'Group was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def comments_create
    @group = Group.find(params[:group_id])
    @content = Content.find(params[:content_id])
    @comment = @content.comments.new()
    @comment.comment = params[:comment]
    @comment.user_name = current_user.email

    @comment.save

    redirect_to user_group_path(current_user.id, @group.id)
  end

  # POST /groups/convert_event/:id
  def convert_event
    @selected = Selected.create(user_id: current_user.id,content_id: params[:id])

    @user = User.find(current_user.id)
    @content = Content.find(params[:id])
    @event = @user.events.create(title: @content.title, content: @content.content, start_date: (@content.start_date.to_time - 9.hours).to_datetime ,end_date:  (@content.end_date.to_time - 9.hours).to_datetime, selected_id: @selected.id)

  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_group
    @group = Group.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def group_params
    # params.require(:group).permit(:title, :description)
  end
end
