class WikisController < ApplicationController
  def show
     @wiki = Wiki.find(params[:id])
   end

   def new
     @wiki = Wiki.new
   end

   def create
     @wiki = Wiki.new
     @wiki.title = params[:title]
     @wiki.body = params[:body]
     @wiki.private = params[:private]
     @wiki = User.find(params[:user_id])
     @wiki.user = @user

     if @wiki.save
       flash[:notice] = "Wiki was saved."
       redirect_to @wiki
     else
       flash.now[:alert] = "There was an error saving the wiki. Please try again."
       render :new
     end
   end
end
