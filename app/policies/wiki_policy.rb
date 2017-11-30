class WikiPolicy < ApplicationPolicy
  def initialize(user, wiki)
    @user = user
    @wiki = wiki
  end
#
#   def update?
#     if @user.admin? || @wiki.user == @user
#       allow_private = true
#     else
#       block_private = true
#     end
#   end
# end

  def destroy?
    user.admin? || @wiki.user == @user
  end

  def permitted_attributes
    if user.admin? || @wiki.user == @user   # user.owner_of?(@wiki)
      [:title, :body, :private]
    else
      [:title, :body]
    end
  end
end
