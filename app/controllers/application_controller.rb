class ApplicationController < ActionController::Base
  protect_from_forgery

  # Returns the current user stored in session
  # or nil if no user is currently logged in.
  def current_user
    User.find(:first, :conditions => {:token => session[:user_token]})
  end

  # Saves the current user
  def set_current_user(user)
    session[:user_token] = user.token
  end
end
