class HomeController < ApplicationController

  def index
    @categories=Item.categories
    @categories=["Todas"]|@categories
  end

end
