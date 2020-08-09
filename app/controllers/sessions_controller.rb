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
      # puts 'good login'
      reset_session
      helpers.log_in @user
      flash[:notice] = 'Logged in!'
      redirect_to @user
    else
      # puts 'bad login'
      flash[:alert] = 'Invalid combination'
      render :new
      # re-render the sessions new form,
      # understanding that the 
    end
  end

  def destroy
    reset_session
    # below may (???) not be necessary
    # because we would essentially be setting sessions[:user_id]=nil
    # helpers.log_out
    redirect_to root_path
  end
end
