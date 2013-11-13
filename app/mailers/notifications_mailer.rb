class NotificationsMailer < ActionMailer::Base
  default from: "\"Test\" <test@carrierwave-s3-upload-test.com>"

  def zip_ready(zip_url, receiver_id)
    @zip_url  = zip_url
    @receiver = User.find(receiver_id)
    mail(:to => @receiver.email, :subject => I18n.t('.mailers.notifications.zip_ready.subject'))
  end

  def zip_request(event, requester)
    @event     = event
    @requester = requester
    mail(:to => 'test@carrierwave-s3-upload-test.com', :subject => I18n.t('.mailers.notifications.zip_request.subject'))
  end
end
