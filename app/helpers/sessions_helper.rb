module SessionsHelper
  def log_in(user)
    session[:user_id] = user.id
    # puts "logging in user #{user.id}"
    # puts session[:user_id]
  end

  def logged_in?
    # puts "checking #{session[:user_id]}"
    # puts session[:user_id].nil? ? "nil, uh oh" : "not nil!" 
    logged_in_via_session = !session[:user_id].nil? && !User.find(session[:user_id]).nil?
    return true if logged_in_via_session

    return false if ( cookies[:user_id].nil? || cookies[:remember_token].nil? )

    puts "cookies still present!"

    user = User.find( cookies.encrypted.permanent[:user_id] )
    return false if user.nil?
    return user.authenticate_remember_token( cookies.encrypted.permanent[:remember_token] )
  end

  def current_user
    if not session[:user_id].nil?
      User.find(session[:user_id])
    elsif (!cookies[:user_id].nil?) && (!cookies[:remember_token].nil?)
      user = User.find(cookies.encrypted[:user_id])
      if !user.nil? && user.authenticate_remember_token(cookies.encrypted[:remember_token])
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
    cookies.encrypted.permanent[:user_id] == user.id && !user.remember_token_digest.nil? && user.authenticate_remember_token(cookies[:remember_token])
  end

  def remember(user)
    new_remember_token = SecureRandom.base64()
    cookies.encrypted.permanent[:user_id] = user.id
    cookies.encrypted.permanent[:remember_token] = new_remember_token
    # below should(?) set remember_token_digest in the database
    user.remember_token = new_remember_token
    user.save!
  end

end
