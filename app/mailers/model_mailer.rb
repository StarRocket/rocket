class ModelMailer < ActionMailer::Base
  default from: "kq1208@gmail.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.model_mailer.new_record_notification.subject
  #
  def new_record_notification(record)
    @greeting = record

    mail to: "dennisieur@hotmail.com", subject: "YES!!"
  end
end
