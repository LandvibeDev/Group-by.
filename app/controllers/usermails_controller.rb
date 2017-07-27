class UsermailsController < ApplicationController
  before_action :set_usermail, only: [:show, :edit, :update, :destroy]

  # GET /usermails
  # GET /usermails.json
  def index
    @userpop = Userpop3.find(current_user.id)
    @usermails = @userpop.usermails.all
  end

  # GET /usermails/1
  # GET /usermails/1.json
  def show
  end

  # GET /usermails/new
  def new
    @usermail = Usermail.new
  end

  # GET /usermails/1/edit
  def edit
  end

  # POST /usermails
  # POST /usermails.json
  def create
    @userpop = Userpop3.find(current_user.id)
    #@usermail = @userpop.usermails.new(usermail_params)

    pop = Userpop3.find(current_user.id)

    Mail.defaults do
      retriever_method :pop3, :address    => pop.pop3,
                       :port       => pop.port,
                       :user_name  => pop.email,
                       :password   => pop.password,
                       :enable_ssl => true
    end

    mail = Mail.find(:what => :first, :count => 2)

    mail.each do |m|
      part_to_use = m.html_part || m.text_part || m

      encoding = part_to_use.content_type_parameters['charset'] if part_to_use.content_type_parameters

      body = part_to_use.body.decoded

      body = body.force_encoding(encoding).encode('UTF-8') if encoding

      @usermail = @userpop.usermails.new(usermail_params)
      @usermail.subject = m.subject
      @usermail.content = m.body.to_s
      @usermail.from = m.from.to_s
      @usermail.to = m.to.to_s
      @usermail.date = m.date.to_s

      respond_to do |format|
        if @usermail.save
          format.html { redirect_to '/usermails' and return }
          format.json { render :show, status: :created, location: @usermail }
        else
          format.html { render :new }
          format.json { render json: @usermail.errors, status: :unprocessable_entity }
        end
      end

    end
  end

  # PATCH/PUT /usermails/1
  # PATCH/PUT /usermails/1.json
  def update
    respond_to do |format|
      if @usermail.update(usermail_params)
        format.html { redirect_to @usermail, notice: 'Usermail was successfully updated.' }
        format.json { render :show, status: :ok, location: @usermail }
      else
        format.html { render :edit }
        format.json { render json: @usermail.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /usermails/1
  # DELETE /usermails/1.json
  def destroy
    @usermail.destroy
    respond_to do |format|
      format.html { redirect_to usermails_url, notice: 'Usermail was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_usermail
    @userpop = Userpop3.find(current_user.id)
    @usermail = @userpop.usermails.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def usermail_params
    #params.require(:usermail).permit(:subject, :content, :date, :from, :to)
  end
end
