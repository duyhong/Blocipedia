class UsersController < ApplicationController
  def downgrade
    wikis = Wiki.where(user_id: current_user.id)
    wikis.each do |wiki|
      wiki.update(private: !wiki.private?)
    end
    current_user.standard!
    redirect_to edit_user_registration_path
  end
end
