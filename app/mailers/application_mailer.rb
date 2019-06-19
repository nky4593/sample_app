class ApplicationMailer < ActionMailer::Base
  default from: Figaro.env.noreply_user
  layout "mailer"
end
