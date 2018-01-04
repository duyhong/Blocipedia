class Wiki < ApplicationRecord
  attr_accessor :selected_option, :removed_collaborator

  belongs_to :user

  has_many :collaborators
  has_many :users, through: :collaborators

  # def collaborators
  #    Collaborator.where(wiki_id: id)
  # end
  #
  # delegate :users, to: :collaborators
  # def users
  #    collaborators.users
  # end

end
