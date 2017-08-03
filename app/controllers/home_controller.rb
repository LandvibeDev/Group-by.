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

  def create_event
    @event = Event.create(title: params[:title],start: params[:start],end: params[:end])

    respond_to do |format|
      format.json {render json: @event}
    end
  end

  def edit_event
    #파라미터 넘어올때 계속 index로 몇번째 event인지만 넘어온다.(0부터 시작)
    @idx = params[:other][:id]
    @event = Event.find(@idx)
    @event.title = params[:title]
    @event.start = params[:start]
    @event.end = params[:end]
    @event.save
  end

  def delete_event
    #앞쪽의 event 삭제시 edit_event에서 활용한 방식이 문제가 된다
    @idx = params[:other][:id];
    @event = Event.find(@idx)
    @event.destroy
  end
end
