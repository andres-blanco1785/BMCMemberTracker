class NotifyPymtMailer < ApplicationMailer
  default from: 'BMCT.test.J@gmail.com'

  def payment_email
    @payment = params[:payment]
	@rec_name = params[:rec_name] # rec short for receiver
	@rec_email = params[:rec_email]
	@off_name = params[:off_name]
	# PLEASE set to: YOUR EMAIL if you are testing and putting in "fake" emails
    mail(to: @rec_email, subject: 'TAMU Badminton Club Dues Confirmation')
  end
end