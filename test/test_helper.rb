ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  # include SessionsHelper
end

class ActionDispatch::IntegrationTest

  # Log in as a particular user.
  def log_in_as(user, password: 'foobar')
    post login_path, params: { session: { email: user.email,
                                          password: password } }
  end

  def log_in_and_remember_as(user, password: 'foobar')
    post login_path, params: { session: {
      email: user.email,
      password: password,
      remember_me: true
    }}
  end


  def logged_in_session?
    # puts "checking #{session[:user_id]}"
    # puts session[:user_id].nil? ? "nil, uh oh" : "not nil!" 
    logged_in_via_session = !session[:user_id].nil? && !User.find(session[:user_id]).nil?
    return logged_in_via_session

  end
end
