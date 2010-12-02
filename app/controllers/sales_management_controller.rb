# -*- coding: utf-8 -*-
class SalesManagementController < ApplicationController
  before_filter :with_valid_user
  #before_filter :with_test_user

  # This action renders the backoffice for management sales
  # for a certain user
  def index
    @sales = @user.sales
  end

  # This action is rendered when a user wishes to create a
  # new sale
  def new
    @sale = Sale.new
  end

  # Creates the sale and check errors
  def create
    @sale = Sale.new(params[:sale])
    @sale.user = @user
    if @sale.save
      flash[:notice] = "La venta ha sido creada con &eacute;xito"
      redirect_to :controller => :items_management,
                  :action     => :index,
                  :sale_id    => @sale.id,
                  :user_id    => @user.id
    else
      flash[:error] = "La venta no ha podido ser creada, repasa la informaci&oacute;n que falta"
      render :new
    end
  end

  # Edits the items in the sale
  def edit
    @sale = Sale.find(:first, :conditions => {:id => params[:sale_id]}, :include => :items)
    if @sale.user != @user
      flash[:error] = "No tienes permisos para editar esa venta"
      redirect_to :index
    else
      render :edit
    end
  end

  # Updates the details of a sale
  def update
    @sale = Sale.find(:first, :conditions => {:id => params[:sale_id]}, :include => :items)
    if @sale.user != @user
      flash[:error] = "No tienes permisos para editar esa venta"
      redirect_to :index
    else
      @sale.update_attributes(params[:sale])
      if @sale.save
        flash[:new] = "La venta se ha actualizado con éxito"
        redirect_to url_for(:action => :index, :controller => :sales_management, :user_id => @user.id)
      else
        flash[:error] = "La venta no ha podido ser creada, repasa la informaci&oacute;n que falta"
        render :edit
      end
    end
  end
end
