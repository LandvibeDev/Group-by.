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

    @groupcategory = GroupCategory.where(:group_id => params[:id])

  end

  # GET /groups/new
  def new
    @group = Group.new
    @user = User.all
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
    @group.groupProfile = params[:groupProfile]
    @group.groupCover = params[:groupCover]

    respond_to do |format|
      if @group.save
        @user.groups << @group

        GroupCategory.new(group_id: @group.id , category_id: params[:category]).save

        format.html { redirect_to user_group_path(current_user.id, @group.id) }
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
    @group.groupProfile = params[:groupProfile]
    @group.groupCover = params[:groupCover]

    @groupcategory = GroupCategory.where(:group_id => params[:id])
    @groupcategory.update(group_id: @group.id , category_id: params[:category])

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

  def join
    @user = User.find(params[:user_id])
    @group = Group.find(params[:group_id])

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
