class SessionsController < ApplicationController
  def new
    @user = User.last
  end

  def create
    puts params[:email] #this successfully logs the passed-in email
    puts params[:password] #this doesn't work, how does rails know not to do this??
    # on the other hand debug(params) exposes it...
    @user = User.find_by email: params[:email] #but replace this 
    if @user
      #successful session creation here
      render :new
    else
      redirect_to root_url
      # re-render the sessions new form,
      # understanding that the 
    end
  end
end
