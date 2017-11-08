class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  after_create :send_new_user_emails

  private

  def send_new_user_emails
    SignUpMailer.new_user.deliver_now
  end
end
