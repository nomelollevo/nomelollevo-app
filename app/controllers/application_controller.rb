class ApplicationController < ActionController::Base
  protect_from_forgery

  protected

  # Returns the current user stored in session
  # or nil if no user is currently logged in.
  def current_user
    User.find(:first, :conditions => {:token => session[:user_token]})
  end

  # Saves the current user
  def set_current_user(user)
    session[:user_token] = user.token
  end

  # Checks that the current user is authenticated

  def with_valid_user
    if(current_user && current_user.id.to_s == params[:user_id].to_s)
      @user = current_user
    else
      flash[:error] = "Debes estar autenticado para acceder a este &aacute;rea"
      redirect_to :controller => :home, :action => :index
    end
  end


  # only for development
  def with_test_user
    raise Exception.new("You cannot use test users in production!") if Rails.env == "production"
    raise Exception.new("You cannot use test users in test!") if Rails.env == "test"

    @user = User.find(:first, :conditions => {:nick => 'test_user'})
    if @user.nil?
      @user = User.new(:nick => "test_user", :email => "user@test.com", :token => "test_token")
      @user.save!
      @user.reload
    end
    set_current_user @user
  end

end
