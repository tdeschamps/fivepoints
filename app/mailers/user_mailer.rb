class UserMailer < ApplicationMailer
	default from: 'thomas@fivemarks.in'
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.welcome.subject
  #
  def welcome(user)

    @user = user

    mail(to: @user.email,
    	subject: 'Welcome to Fivemarks') do |format|
      format.html { render layout: 'email', locals: {title: "Welcome to fivemarks"} }
      format.text
    end
  end
end
