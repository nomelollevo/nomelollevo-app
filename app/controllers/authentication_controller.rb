require "#{Rails.root}/lib/authentication/facebook"

class AuthenticationController < ApplicationController

  include Authentication::Facebook

  # Allows users withouth js to select an authentication mechanism
  def index
  end

  # Clients will be directed to this action when
  # they click the login with facebook button in
  # the home page.
  # This action will take care of starting the OAuth
  # authentication process with Facebook
  def facebook_request
    redirect_to facebook_authenticate_url
  end

  # Facebook will redirect the authenticated user to this
  # action
  def facebook_callback
    user = parse_facebook_user_data
    u = User.new(:email => user["email"], :nick => user["first_name"])
    u.save!

    session[:user_id] = u.id

    render :text => "ok"
  end
end
