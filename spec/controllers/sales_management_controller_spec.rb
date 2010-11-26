require 'spec_helper'

describe SalesManagementController do

  include Factories

  it "should not allow to access users without authentication" do
    controller.session[:user_token] = nil

    get :index, :user_id => "1"

    controller.flash[:error].should_not be_nil
    response.should redirect_to(:controller => :home, :action => :index)
  end

  # index action

  it "should retrieve all the sales associated to the user" do
    with_authenticated_user do |user|

      s1 = factory_build :valid_unlimited_sale
      s2 = factory_build :valid_unlimited_sale
      user.sales << s1
      user.sales << s2
      user.save!

      get :index, :user_id => user.id

      response.should be_success
      assigns(:sales).should have(2).sales
    end
  end
end

