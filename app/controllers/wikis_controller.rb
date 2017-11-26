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
     @wiki = Wiki.new(wiki_params)
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
     authorize @wiki
     @wiki.assign_attributes(wiki_params)

     if @wiki.save
       flash[:notice] = "Wiki was updated."
       redirect_to @wiki
     else
       flash.now[:alert] = "There was an error saving the wiki. Please try again."
       render :edit
     end
   end

   def destroy
     @wiki = Wiki.find(params[:id])
     if @wiki.destroy
       flash[:notice] = "\"#{@wiki.title}\" was deleted successfully."
       redirect_to action: :index
     else
       flash.now[:alert] = "There was an error deleting the post."
       render :show
     end
   end

   # remember to add private methods to the bottom of the file. Any method defined below private, will be private.
   private
   def wiki_params
     params.require(:wiki).permit(:title, :body, :private)
   end

   # def authorize_user
   #   wiki = Wiki.find(params[:id])
   #   unless current_user == wiki.user
   #     flash[:alert] = "You must sign in to do that."
   #     redirect_to wiki
   #   end
   # end
end
