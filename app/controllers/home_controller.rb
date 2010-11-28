class HomeController < ApplicationController

  def index
    @categories=Item.categories
  end

end
