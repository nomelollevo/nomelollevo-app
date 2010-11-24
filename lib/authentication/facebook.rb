require 'oauth2'
require 'json'

# This class handles the authentication logic
# with Facebook using OAuth
module Authentication
  module Facebook


    # Creates a new client
    def facebook_client
      OAuth2::Client.new(Settings.authentication.facebook.app_id,
                         Settings.authentication.facebook.app_secret,
                         :site => Settings.authentication.facebook.site,
                         :ssl => {:verify => false})
    end

    # Generates the URL for OAuth authentication in Facebook
    def facebook_authenticate_url
      facebook_client.web_server.authorize_url(:redirect_uri => Settings.authentication.facebook.callback_url,
                                               :scope => Settings.authentication.facebook.scope)
    end

    # Returns a Hash with user data, once the user has been authenticated
    def parse_facebook_user_data
      access_token = facebook_client.web_server.access_token(params[:code],
                                                             :redirect_uri => Settings.authentication.facebook.callback_url)
      user = JSON.parse(access_token.get('/me'))

      user.inspect
    end

  end
end
