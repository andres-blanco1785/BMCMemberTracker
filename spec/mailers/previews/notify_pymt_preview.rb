# Preview all emails at http://localhost:3000/rails/mailers/notify_pymt
class NotifyPymtPreview < ActionMailer::Preview
  def payment_email
    NotifyPymtMailer.with(payment: Payment.first).payment_email
  end
end
