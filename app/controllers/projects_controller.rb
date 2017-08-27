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

    # 프로젝트의 가입된 유저 check
    @check_project_user = ProjectsUser.where(user: current_user, project: @project)
    if(@check_project_user.empty?)
      redirect_to notfind_projects_path
    else
      @team_events = @project.team_events.order('start_date')

      @users = User.all

      @userprojects = ProjectsUser.all

      @check_user_event = TeamEventsUser.where(user_id: current_user.id)

    end
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
        @user.projects_users.create(project: @project, admin_user: true)

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
    @project = Project.find(params[:id])

    @team_events = TeamEvent.where(project: @project)
    @team_events.each do |team_event|
      team_event.destroy
      @user_team_events = TeamEventsUser.where(team_event: team_event)
      @user_team_events.each do |user_team_event|
        user_team_event.destroy
      end
    end

    @project_users = ProjectsUser.where(project: @project)
    @project_users.each do |project_user|
      project_user.destroy
    end

    @pushs = Push.where(pusher_id: @project, push_num: 2)
    @pushs.each do |push|
      push.destroy
    end

    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_path, notice: 'Project was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # POST /projects/:project_id/save
  def save
    @project = Project.find(params[:project_id])

    #push
    @project.users.each do |user|
      if user.id != current_user.id
        user.pushs.create(message: @project.title, pusher_id: @project.id, push_num: 3)
      end
    end

    path = '/projects/' + @project.id.to_s

    redirect_to path
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

    #push
    @user.pushs.create(message: @project.title, pusher_id: params[:project_id], push_num: 2)

    redirect_to project_path(@project.id)
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
        @user.projects_users.create(project: @project, admin_user: false)
        format.html { redirect_to project_path(@project.id)}
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
    @event = TeamEvent.create(project: @project, title: params[:title],content: params[:other][:desc], start_date: params[:start],end_date: params[:end], image: params[:image])

    @project.update(updated_at: Time.now)

    respond_to do |format|
      @user.team_events_users.create(team_event: @event, complete: false)
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

  def image_teamEvent
    @project = Project.find(params[:id])
    @event = TeamEvent.find(params[:event_id])
    @event.teamEventImage = params[:teamEventImage]
    @event.teamEventFile = params[:teamEventFile]
    @event.save

    redirect_to project_path(@project.id)
  end

  #admin관리
  def admin_user_add
    @user = User.find(params[:user_id])
    @project = Project.find(params[:project_id])

    @admin_user = ProjectsUser.where(user: @user, project: @project)
    @admin_user.update(admin_user: true)

    redirect_to project_path(@project.id)
  end

  def admin_user_destroy
    @user = User.find(params[:user_id])
    @project = Project.find(params[:project_id])

    @admin_user = ProjectsUser.where(user: @user, project: @project)
    @admin_user.update(admin_user: false)

    redirect_to project_path(@project.id)
  end

  #user -> event 추가
  def user_event_add
    @user = User.find(current_user.id)
    @event = TeamEvent.find(params[:event_id])
    @user.projects_users.create(project: @project, admin_user: false)

    @user.team_events_users.create(team_event: @event, complete: false)

    @user_event = @user.events.create(title: @event.title,content: @event.content, start_date: @event.start_date ,end_date: @event.end_date)
  end

  def user_event_complete
    @user = User.find(current_user.id)
    @event = TeamEvent.find(params[:event_id])
    @event_user = TeamEventsUser.where(team_event: @event, user: @user)
    @event_user.update(complete: true)
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
