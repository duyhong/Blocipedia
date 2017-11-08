if Rails.env.development? || Rails.env.production?
    ActionMailer::Base.delivery_method = :smtp
    ActionMailer::Base.smtp_settings = {
      address:         'smtp.gmail.com',  # 'smtp.sendgrid.net',
      port:           587,  # '2525',
      authentication: :plain,
      user_name:      ENV["GMAIL_USERNAME"],  # ENV['SENDGRID_USERNAME'],
      password:       ENV["GMAIL_PASSWORD"],  # ENV['SENDGRID_PASSWORD'],
      domain:         'heroku.com',
      enable_starttls_auto: true
    }
end
