# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'BMCT.test.J@gmail.com'
  layout 'mailer'
end
