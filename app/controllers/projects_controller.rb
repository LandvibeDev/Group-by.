class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]

  # GET /projects
  # GET /projects.json
  def index
    @user = User.find(current_user.id)
    @projects = @user.projects.all
  end

  def calendar
    @project = Project.find(params[:project_id])
    @events = TeamEvent.all
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    @project = Project.find(params[:id])
    @team_events = @project.team_events.order('start_date')

    @users = User.all

    @userprojects = ProjectsUser.all
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
        format.html { redirect_to project_calendar_path(@project.id) }
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

  # 초대 기능
  # GET /groups
  def inviteCreate
    @users = User.all
    @project = Project.find(params[:project_id])

    @user = User.find(params[:user_id])
    @currentuser = User.find(current_user.id)
    @invite = @currentuser.invites.new(invite_user: params[:user_id], invite_project: params[:project_id], invite_user_email: @user.email, invite_project_title: @project.title)
    @invite.save

    @user.pushs.create(message: @project.title, pusher_id: params[:project_id], isGroup: false)

    redirect_to user_project_path(current_user.id, @project.id)
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
        format.html { redirect_to user_project_path(current_user.id, @project.id)}
        format.json { render :show, status: :created, location: @group }
      else
        format.html { render :new }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  #팀 이벤트
  def load_teamEvent
    @project = Project.find(params[:id])
    @events = @project.team_events.all
    render json: @events
  end

  def new_load_teamEvent
    @project = Project.find(params[:project_id])
    @event = @project.team_events.order("created_at").last
    render json: @event
  end

  def current_load_teamEvent
    @event = TeamEvent.find(params[:event_id])
    render json: @event
  end

  def create_teamEvent
    @user = User.find(current_user.id)
    @project = Project.find(params[:project_id])
    @event = @project.team_events.create(title: params[:title],content: params[:other][:desc], start_date: params[:start],end_date: params[:end], image: params[:image])

    respond_to do |format|
      @user.team_events << @event
      format.json {render json: @event}
    end
  end

  def edit_teamEvent
    #파라미터 넘어올때 계속 index로 몇번째 event인지만 넘어온다.(0부터 시작)
    @event = TeamEvent.find(params[:id])
    @event.title = params[:title]
    @event.content = params[:other][:desc]
    @event.start_date = params[:start]
    @event.end_date = params[:end]
    @event.image = params[:image]
    @event.save
  end

  def delete_teamEvent
    #앞쪽의 event 삭제시 edit_event에서 활용한 방식이 문제가 된다
    # @idx = params[:other][:id]
    # @event = TeamEvent.find(@idx)

    @event = TeamEvent.find(params[:id])
    @event.destroy
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
