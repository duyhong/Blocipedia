class UsersController < ApplicationController
  def downgrade
    wikis = Wiki.where(user_id: current_user.id)
    wikis.each do |wiki|
      wiki.update(private: !wiki.private?)
    end
    current_user.standard!
    flash[:notice] = "Your private wikis will become public after you downgrade your account."
    redirect_to edit_user_registration_path
  end
end
