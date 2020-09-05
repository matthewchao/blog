# DO NOT USE .FIND()! iT RAISES AN EXCEPTION. FIND BY ID OR SOMETHING
module SessionsHelper
  def log_in(user)
    session[:user_id] = user.id
    # puts "logging in user #{user.id}"
    # puts session[:user_id]
  end

  def logged_in?
    # puts "checking #{session[:user_id]}"
    # puts session[:user_id].nil? ? "nil, uh oh" : "not nil!" 
    logged_in_via_session = !session[:user_id].nil? && !User.find_by(id: session[:user_id]).nil?
    return true if logged_in_via_session

    # Not logged_in via the session; see if logged in via cookies
    if ( cookies[:user_id].nil? || cookies[:remember_token].nil? )
      puts "not logged in via session and not logged in via cookies"
      return false
    end

    puts "cookies still present!"

    user = User.find_by( id: cookies.encrypted.permanent[:user_id] )
    return false if user.nil?
    return user.authenticate_remember_token( cookies.encrypted.permanent[:remember_token] )
  end

  def current_user
    if not session[:user_id].nil?
      puts "foudn user by session"
      User.find_by( id: session[:user_id])
    elsif (!cookies[:user_id].nil?) && (!cookies[:remember_token].nil?)
      
      user = User.find_by( id: cookies.encrypted[:user_id])
      if !user.nil? && user.authenticate_remember_token(cookies.encrypted[:remember_token])
        puts "foudn user by cookie"
        return user
      end
    else
      puts "no current user!"      
    end
  end

  def current_user?(user)
    current_user==user
  end

  def remembered?(user)
    puts "user #{user.name} is remembered!"
    cookies.encrypted.permanent[:user_id] == user.id && 
    !user.remember_token_digest.nil? && 
    user.authenticate_remember_token(cookies[:remember_token])
  end

  def remember(user)
    puts "REMBERING USER"
    new_remember_token = SecureRandom.base64()
    cookies.encrypted.permanent[:user_id] = user.id
    cookies.encrypted.permanent[:remember_token] = new_remember_token
    # below should(?) set remember_token_digest in the database
    user.remember_token = new_remember_token
    user.save!
  end

  def delete_remember_cookies
    cookies.delete :user_id
    cookies.delete :remember_token
  end

end
