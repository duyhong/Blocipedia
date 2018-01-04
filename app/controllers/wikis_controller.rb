class WikisController < ApplicationController
  # before_action :require_sign_in, except: :show
  # before_action :authorize_user, except: [:show, :new, :create]

  def index
     @wikis = policy_scope(Wiki)
  end

  def show
     @wiki = Wiki.find(params[:id])
   end

   def new
     @wiki = Wiki.new
   end

   def create
     @wiki = Wiki.new(params_for_create)
     # @wiki.assign_attributes(wiki_params)
     # @wiki.title = params[:wiki][:title]
     # @wiki.body = params[:wiki][:body]
     # @wiki.private = params[:wiki][:private]
     # @user = User.find(params[:user_id])
     @wiki.user = current_user # @user

     if @wiki.save
       flash[:notice] = "Wiki was saved."
       redirect_to @wiki
     else
       flash.now[:alert] = "There was an error saving the wiki. Please try again."
       render :new
     end
   end

   def edit
     @wiki = Wiki.find(params[:id])
     # @potential_collaborators -> all users except current user and existing collaborators
     @potential_collaborators = [] # In _form.html.erb,
                                   # use @potential_collaborators to populate a select list,
                                   # value of option in select tag to be the user id,
                                   # select called collaborator_id
     @existing_collaborators = []
     users = User.all
     users.each do |user|
       if current_user != user
          if @wiki.users.include?(user)
             @existing_collaborators << user
          else
             @potential_collaborators << user
          end
       end
     end
   end

   def update
     @wiki = Wiki.find(params[:id])     # authorize @wiki
     if params[:wiki][:selected_option].present?
       @user = User.find(params[:wiki][:selected_option])
       Collaborator.create!(wiki: @wiki, user: @user, created_at: Time.now)
     end
     @wiki.collaborators.where(user_id: params[:wiki][:removed_collaborator]).destroy_all

     # @wiki.assign_attributes(wiki_params)
     # if @wiki.save
     # if @wiki.update_attributes(wiki_params)
     if @wiki.update_attributes(permitted_attributes(@wiki))
       flash[:notice] = "Wiki was updated."
       redirect_to @wiki
     else
       flash.now[:alert] = "There was an error saving the wiki. Please try again."
       render :edit
     end
   end

   def destroy
     @wiki = Wiki.find(params[:id])
     authorize @wiki
     if @wiki.destroy
       flash[:notice] = "\"#{@wiki.title}\" was deleted successfully."
       redirect_to action: :index
     else
       flash.now[:alert] = "There was an error deleting the post."
       render :show
     end
   end

   rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

   # remember to add private methods to the bottom of the file. Any method defined below private, will be private.
   private

   def params_for_create
     if current_user.premium? || current_user.admin?
       params.require(:wiki).permit(:title, :body, :private)
     else
       params.require(:wiki).permit(:title, :body)
     end
   end

   # def collaborator_params
   #   params.require(:collaborator).permit(:wiki_id, :user_id)
   # end

   # def wiki_params
   #   params.require(:wiki).permit(policy(@wiki).permitted_attributes)
   # end

    def user_not_authorized(exception)
      wiki_policy = exception.policy.class.to_s.underscore

      flash[:alert] = "You are not authorized to do that!"
      redirect_to(request.referrer || root_path)
    end

   # def authorize_user
   #   wiki = Wiki.find(params[:id])
   #   unless current_user == wiki.user
   #     flash[:alert] = "You must sign in to do that."
   #     redirect_to wiki
   #   end
   # end
end
