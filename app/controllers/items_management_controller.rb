# -*- coding: utf-8 -*-
class ItemsManagementController < ApplicationController
  before_filter :with_valid_user
  #before_filter :with_test_user
  before_filter :with_valid_sale

  # Shows all the items associated to a sale
  def index
    @items = @sale.items
  end

  # New item for a sale form
  def new
    @item = Item.new
  end

  # Creates a new item and redirects to
  # the index of the item management
  def create
    @item = Item.new(params[:item])
    @item.is_published = params[:should_publish] == "publicar" ? true : false
    @item.sale = @sale
    if @item.save
      flash[:notice] = "El artículo ha sido guardado con éxito"
      redirect_to :action => :index, :user_id => @user.id, :sale_id => @sale.id
    else
      flash[:error] = "El artículo no ha podido ser guardado, repasa la informaci&oacute;n que falta"
      render :new
    end
  end

  private

  # Sets the sale object for the
  # required action and checks that
  # it belongs to the current user
  def with_valid_sale
    if(current_user && params[:sale_id])
      @sale = Sale.find(:first,
                        :conditions => {:id => params[:sale_id],
                                        :user_id => current_user.id},
                        :include => :items)
      if @sale.nil?
        flash[:error] = "Debes estar autenticado para acceder a esta &aacute;rea"
        redirect :controller => :home, :action => :index
      end
    else
      flash[:error] = "Debes estar autenticado para acceder a esta &aacute;rea"
      redirect :controller => :home, :action => :index
    end
  end

end
