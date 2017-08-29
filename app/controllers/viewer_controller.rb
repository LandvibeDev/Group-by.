class ViewerController < ApplicationController
  def index
    response.headers.delete "X-Frame-Options"
    render :layout => false
  end
end
