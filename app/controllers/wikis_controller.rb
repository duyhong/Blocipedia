class WikisController < ApplicationController
  # before_action :require_sign_in, except: :show
  # before_action :authorize_user, except: [:show, :new, :create]

  def index
     @wikis = Wiki.all
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
   end

   def update
     @wiki = Wiki.find(params[:id])
     # authorize @wiki
     # @wiki.assign_attributes(wiki_params)

     # if @wiki.save
     if @wiki.update_attributes(wiki_params)
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
     params.require(:wiki).permit(:title, :body, :private)
   end

   def wiki_params
     params.require(:wiki).permit(policy(@wiki).permitted_attributes)
   end

    def user_not_authorized(exception)
      wiki_policy = exception.policy.class.to_s.underscore

      flash[:error] = t "#{wiki_policy}.#{exception.query}", scope: "pundit", default: :default
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
