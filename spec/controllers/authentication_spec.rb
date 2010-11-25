require 'spec_helper'

describe AuthenticationController do
  it "should create a new user model object if the user is not registered" do
    User.destroy_all

    facebook_client = mock()
    webserver = mock()
    access_token = mock()

    controller.stub!(:facebook_client).and_return(facebook_client)
    facebook_client.stub!(:web_server).and_return(webserver)
    webserver.stub!(:access_token).and_return(access_token)

    access_token.should_receive(:get).with("/me").and_return('{"name":"Miguel de Romanones", "timezone":1, "gender":"male", "id":"100001903308264", "last_name":"de Romanones", "verified":true, "locale":"es_ES", "link":"http://www.facebook.com/profile.php?id=100001903308264", "email":"migelromanones@gmail.com", "first_name":"Miguel"}')

    get 'facebook_callback', {:code => "the_code"}

    response.should be_success

    User.first.nick.should be_eql("Miguel")
    User.first.email.should be_eql("migelromanones@gmail.com")
  end

  it "should store the user in session after potentially saving it" do
    User.destroy_all

    facebook_client = mock()
    webserver = mock()
    access_token = mock()

    controller.stub!(:facebook_client).and_return(facebook_client)
    facebook_client.stub!(:web_server).and_return(webserver)
    webserver.stub!(:access_token).and_return(access_token)

    access_token.should_receive(:get).with("/me").and_return('{"name":"Miguel de Romanones", "timezone":1, "gender":"male", "id":"100001903308264", "last_name":"de Romanones", "verified":true, "locale":"es_ES", "link":"http://www.facebook.com/profile.php?id=100001903308264", "email":"migelromanones@gmail.com", "first_name":"Miguel"}')

    get 'facebook_callback', {:code => "the_code"}

    response.should be_success

    controller.session[:user_id].should_not be_nil
  end
end
