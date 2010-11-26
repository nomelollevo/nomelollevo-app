require "#{Rails.root}/lib/authentication/facebook"
require "digest/md5"

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
    user_data = parse_facebook_user_data
    token = sign_user_token(user_data["email"],"facebook")

    user =  User.find_by_token(token)
    if user
      set_current_user(user)
    else
      user = User.new(:email => user_data["email"],
                      :nick  => user_data["first_name"],
                      :token => token)
      user.save!

      set_current_user(user)
    end
    redirect_to :controller => "sales_management",
                :action     => "index",
                :user_id    => user.id
  end

  private

  # Generates a token for the user
  def sign_user_token(email, salt)
    Digest::MD5.hexdigest("#{email}:#{salt}")
  end

end
