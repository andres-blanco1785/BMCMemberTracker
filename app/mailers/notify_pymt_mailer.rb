class NotifyPymtMailer < ApplicationMailer
  default from: 'BMCT.test.J@gmail.com'

  def payment_email
    #@user = params[:user]
    #@url  = 'http://example.com/login'
    #mail(to: @user.email, subject: 'Welcome to My Awesome Site')
    @payment = params[:payment]
    @url  = 'http://example.com/login'
	#deliver_options = {user_name: 'BMCT.test.J@gmail.com',
	#				   password: '0nward!J',
	#				   address: 'smtp.gmail.com' }
    mail(to: 'ja7davis@gmail.com', subject: 'BMCT Payment email subject in notify_pymt_mailer.rb')
  end
end
