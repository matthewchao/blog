class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_user, only: [:edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show

    # EXPERIMENT BELOW WITH PASSING THE PARAMS FROM CREATE TO FIND A USER HERE;
    # @user = User.find(params[:id])
    # if @user.nil?
    #   @user = User.new
    # end
    # NB: it didn't make sense to do above when we issue a get request to users/3
    # then @user is already implicity set to User.find(3) in the "show" view
  end

  # GET /users/new
  def new
    # This @user instance will be available in the _form view
    # Note we can just refer to it as user (without the '@') there!
    # The below is so that the part of the form which shows errors
    # doesn't return no-method-defined error when we try to call user.errors
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    # https://stackoverflow.com/a/6886316/5418498    
    # from here we can see that params[:id] will come from
    # users/:id, e.g., users/3/edit being routed here
    # means we params[:id]=3

  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    if @user.save
        redirect_to login_path, notice: 'User successfully created. You can now log in.' 
    else
        # the failed save will add stuff to @users.errors because of the validation step
        # performed in .save
        # see https://guides.rubyonrails.org/active_record_validations.html#validations-overview-errors
        render :new
        # below was a successful experiment in trying not to redirect to /users 
        # after a failed signup and instead staying on /users/new -- However this is against convention
        # and the user also loses the progress in writing the form
        # whereas the above render :new doesn't change @user and so form_with in _form view
        # can fill in all fields with what the customer already typed
        # One potential remedy is to pass the current @user as a parameter
        # but the problem is that redirect_to is a GET request which doesn't take parameters
        # redirect_to new_user_url, alert: 'User was not successfully created.'
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def logged_in_user
      puts logged_in?  ? "logged in!" : "not logged in!"
      if  !logged_in?
        redirect_to login_path, alert: 'Not logged in!'
      end
    end

    def correct_user
      # @user is the one found from the url, i.e., user #3 in users/3/edit
      if !current_user?(@user)
        redirect_to root_path, alert: 'Wrong user!'
      end
      
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
      puts @user.nil? ? "couldn't set user" : "successfuly set user!"
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
