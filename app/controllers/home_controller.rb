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
end
