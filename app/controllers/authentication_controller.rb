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
    user = parse_facebook_user_data
    u = User.new(:email => user["email"],
                 :nick  => user["first_name"],
                 :token => sign_user_token(user["email"],"facebook"))
    u.save!

    set_current_user(u)

    redirect_to :controller => "sales_management",
                :action     => "index",
                :user_id    => u.id
  end

  private

  # Generates a token for the user
  def sign_user_token(email, salt)
    Digest::MD5.hexdigest("#{email}:#{salt}")
  end

end
