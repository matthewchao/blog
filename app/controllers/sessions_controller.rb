class SessionsController < ApplicationController
  def new
    @user = User.last
  end

  def create
    puts params[:email] #this successfully logs the passed-in email
    puts params[:password] #this doesn't work, how does rails know not to do this??
    # on the other hand debug(params) exposes it...
    @user = User.find_by email: params[:session][:email] #but replace this 
    # recall that .authenticate is automatically provided by using has_secure_passowrd
    # on the user model
    if @user && @user.authenticate( params[:session][:password] )
      #successful session creation here
      puts 'good login'
      flash[:notice] = 'Logged in!'
      redirect_to @user
    else
      puts 'bad login'
      # note the use of flash.now; this is because render doesn't count as a "request"
      # and so the user would 
      flash[:alert] = 'Invalid combination'
      render :new
      # re-render the sessions new form,
      # understanding that the 
    end
  end
end
