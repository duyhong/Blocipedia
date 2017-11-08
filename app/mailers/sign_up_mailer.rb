class SignUpMailer < ApplicationMailer
  default from: "duyhong@ymail.com"

  def new_user(user)
    #  headers["Message-ID"] = "<users/#{user.id}@your-app-name.example>"
    #  headers["In-Reply-To"] = "<user/#{user.id}@your-app-name.example>"
    #  headers["References"] = "<user/#{user.id}@your-app-name.example>"

    @user = user

     mail(to: user.email, subject: "New user with email #{user.email}")
   end
end
