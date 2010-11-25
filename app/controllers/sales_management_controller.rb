class SalesManagementController < ApplicationController

  # This action renders the backoffice for management sales
  # for a certain user
  def index
    with_valid_user do |user|

    end
  end

  private

  # Checks that the current user is authenticated
  def with_valid_user
    if(current_user && current_user.id == params[:user_id])
      @user = current_user
      yield @user
    else
      flash[:error] = "Debes estar autenticado para acceder a este &aacute;rea"
      redirect_to :controller => :home, :action => :index
    end
  end
end
