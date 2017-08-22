class HomeController < ApplicationController
  before_action :authenticate_user!, only: [:index, :eamil]

  def index
  end

  def email
    pop = Userpop3.find(current_user.id)
    @emails = pop.usermails.all

    respond_to do |format|
      format.html
      format.js
      format.json { render json: @email }
    end
  end

  def load_event
    @events = Event.all;
    render json: @events
  end

  def new_load_event
    @event = Event.order('created_at').last
    render json: @event
  end

  def current_load_event
    @event = Event.find(params[:id])
    render json: @event
  end

  def create_event
    @user = User.find(current_user.id)
    @event = @user.events.create(title: params[:title],content: params[:other][:desc], start_date: params[:start],end_date: params[:end])

    respond_to do |format|
      format.json {render json: @event}
    end
  end

  def edit_event
    #파라미터 넘어올때 계속 index로 몇번째 event인지만 넘어온다.(0부터 시작)
    @idx = params[:other][:id]
    @event = Event.find(@idx)
    @event.title = params[:title]
    @event.content = params[:other][:desc]
    @event.start_date = params[:start]
    @event.end_date = params[:end]
    @event.save
  end

  def delete_event
    #앞쪽의 event 삭제시 edit_event에서 활용한 방식이 문제가 된다
    @idx = params[:other][:id]
    @event = Event.find(@idx)
    @event.destroy
  end
end
