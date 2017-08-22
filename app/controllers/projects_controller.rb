class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]

  # GET /projects
  # GET /projects.json
  def index
    @user = User.find(current_user.id)
    @projects = @user.projects.all
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    @project = Project.find(params[:id])
  end

  # GET /projects/new
  def new
    @project = Project.new
  end

  # GET /projects/1/edit
  def edit
  end

  # POST /projects
  # POST /projects.json
  def create
    @user = User.find(current_user.id)
    @project = Project.new(project_params)

    @project.title = params[:title]
    @project.complete = false

    respond_to do |format|
      if @project.save
        @user.projects << @project
        format.html { redirect_to user_project_path(current_user.id, @project.id) }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url, notice: 'Project was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # GET /groups
  def inviteCreate
    @users = User.all
    @project = Project.find(params[:project_id])

    @user = User.find(current_user.id)
    @invite = @user.invites.new(invite_user: params[:user_id], invite_project: params[:project_id])
    @invite.save

    redirect_to user_group_invite_path(current_user.id, params[:project_id])
  end

  # GET /groups
  def invite
    @users = User.all
    @project = Project.find(params[:project_id])

    @userprojects = ProjectsUser.all
  end

  # UPDATE /groups/join/1
  def join
    @user = User.find(params[:user_id])
    @project = Project.find(params[:project_id])

    @invite = Invite.where(:invite_project => params[:project_id], :invite_user => params[:user_id])
    @invite.delete_all

    respond_to do |format|
      if @project.save
        @user.projects << @project
        format.html { redirect_to user_group_path(current_user.id, params[:project_id])}
        format.json { render :show, status: :created, location: @group }
      else
        format.html { render :new }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      # @project = Project.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      # params.require(:project).permit(:title)
    end
end
