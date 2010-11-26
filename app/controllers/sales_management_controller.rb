class SalesManagementController < ApplicationController
  before_filter :with_valid_user
  #before_filter :with_test_user

  # This action renders the backoffice for management sales
  # for a certain user
  def index
    @sales = @user.sales
  end

  def new

  end

  private

  # Checks that the current user is authenticated

  def with_valid_user
    if(current_user && current_user.id == params[:user_id])
      @user = current_user
    else
      flash[:error] = "Debes estar autenticado para acceder a este &aacute;rea"
      redirect_to :controller => :home, :action => :index
    end
  end

end
