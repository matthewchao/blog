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
    User.find(session[:user_id])
  end

  def current_user?(user)
    current_user==user
  end
end
