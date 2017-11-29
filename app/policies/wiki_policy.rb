class WikiPolicy < ApplicationPolicy
  def initialize(user, wiki)
    @user = user
    @wiki = wiki
#    @deleting_private = true
  end

  def update?
    if @user.admin? || @wiki.user == current_user
      deleting_private = true
    else
      deleting_private = false
    end
  end
end
