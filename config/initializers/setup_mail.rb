if  Rails.env.production? # Rails.env.development? ||
    ActionMailer::Base.delivery_method = :smtp
    ActionMailer::Base.smtp_settings = {
      address:        'smtp.sendgrid.net',
      port:           '2525',
      authentication: :plain,
      # user_name:      'app80633432@heroku.com',
      user_name:      ENV['SENDGRID_USERNAME'],  # 'app80633432@heroku.com',
      # password:       'ky5h3rqm5034',
      password:       ENV['SENDGRID_PASSWORD'], # 'ky5h3rqm5034',
      domain:         'heroku.com',
      enable_starttls_auto: true
    }
end
