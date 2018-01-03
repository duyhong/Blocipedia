class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable

  after_initialize { self.role ||= :standard }

  after_create :send_new_user_emails

  enum role: [:standard, :premium, :admin]

  has_many :collaborators
  has_many :wikis, through: :collaborators

  # def collaborators
  #    Collaborator.where(user_id: id)
  # end
  #
  # delegate :wikis, to: :collaborators
  # def wikis
  #    collaborators.wikis
  # end

  private

  def send_new_user_emails
    SignUpMailer.new_user(self).deliver_now
  end
end
