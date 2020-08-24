module SessionsHelper
  def log_in(user)
    session[:user_id] = user.id
    # puts "logging in user #{user.id}"
    # puts session[:user_id]
  end

  def logged_in?
    # puts "checking #{session[:user_id]}"
    # puts session[:user_id].nil? ? "nil, uh oh" : "not nil!" 
    !session[:user_id].nil? && !User.find(session[:user_id]).nil?
  end

  def current_user
    if not session[:user_id].nil?
      User.find(session[:user_id])
    end
  end

  def current_user?(user)
    current_user==user
  end

  def remember(user)
    new_remember_token = SecureRandom.base64()
    cookies.encrypted.permanent[:remember_token] = new_remember_token
    user.remember_token = new_remember_token
    
  end
end
