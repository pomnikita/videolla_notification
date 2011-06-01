class VideollaNotificationNotifier < ActionMailer::Base
  default :from => "support@videolla.com"
  
  def new_notification(model_object, recipients=['pomnikita@gmail.com'], options={})
    @current_env = Rails.env
    @mail_template = model_object.load_template
    subject = @mail_template.subject
    body = @mail_template.parse_with(model_object)
    mail( :to => recipients, :subject => subject, :body => body)
  end
end