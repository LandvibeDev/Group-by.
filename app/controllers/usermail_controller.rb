class UsermailController < ApplicationController
  helper UsermailHelper

  def insertmail
    userpop3 = Userpop3.find(params[:id])
    pop = Userpop3.find(params[:id])

    Mail.defaults do
      retriever_method :pop3, :address    => pop.pop3,
                       :port       => pop.port,
                       :user_name  => pop.email,
                       :password   => pop.password,
                       :enable_ssl => true
    end

    mail = Mail.find(:what => :first, :count => 2)

    mail.each do |m|
      # select the part to use, either like shown above, or as one-liner
      part_to_use = m.html_part || m.text_part || m

# readout the encoding (charset) of the part
      encoding = part_to_use.content_type_parameters['charset'] if part_to_use.content_type_parameters

# get the message body without the header information
      body = part_to_use.body.decoded

# and convert it to UTF-8
      body = body.force_encoding(encoding).encode('UTF-8') if encoding

      @mails = userpop3.usermails.new(subject: m.subject, content: m.body.to_s, from: m.from.to_s, to: m.to.to_s, date: m.date.to_s)

      @mails.save
    end

    redirect_to '/home/email'
  end
end
