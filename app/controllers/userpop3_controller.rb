class Userpop3Controller < ApplicationController
  before_action :authenticate_user!, only: [:setpop]

  def setpop
    @user = User.find(current_user.id)
    @pop = @user.userpop3s.new(title: params[:title], email: params[:email], password: params[:password], port: params[:port], pop3: params[:pop3])

    @pop.save

    redirect_to userpop3_usermails_path(1)
  end
end
#
# class UsermailController < ApplicationController
#   helper UsermailHelper
#
#   def insertmail
#     userpop3 = Userpop3.find(params[:id])
#     pop = Userpop3.find(params[:id])
#
#     Mail.defaults do
#       retriever_method :pop3, :address    => pop.pop3,
#                        :port       => pop.port,
#                        :user_name  => pop.email,
#                        :password   => pop.password,
#                        :enable_ssl => true
#     end
#
#     mail = Mail.find(:what => :first, :count => 2)
#
#     mail.each do |m|
#       part_to_use = m.html_part || m.text_part || m
#
#       encoding = part_to_use.content_type_parameters['charset'] if part_to_use.content_type_parameters
#
#       body = part_to_use.body.decoded
#
#       body = body.force_encoding(encoding).encode('UTF-8') if encoding
#
#       @mails = userpop3.usermails.new(subject: m.subject, content: m.body.to_s, from: m.from.to_s, to: m.to.to_s, date: m.date.to_s)
#
#       respond_to do |format|
#         if @mails.save
#           format.html { redirect_to @post, notice: 'Post was successfully created.' }
#           format.json { render :email, status: :created, location: @mails }
#         end
#       end
#     end
#
#     redirect_to '/home/email'
#   end
# end
