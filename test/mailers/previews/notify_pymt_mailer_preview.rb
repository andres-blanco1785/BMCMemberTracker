class NotifyPymtPreview < ActionMailer::Preview
  def payment_email
    NotifyPymtMailer.with(payment: Payment.first).payment_email
  end
end