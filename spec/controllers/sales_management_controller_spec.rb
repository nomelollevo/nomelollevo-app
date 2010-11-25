require 'spec_helper'

describe SalesManagementController do

  it "should not allow to access users without authentication" do
    controller.session[:user_id] = nil

    get :index, :user_id => "1"

    controller.flash[:error].should_not be_nil
    response.should redirect_to(:controller => :home, :action => :index)
  end

end
