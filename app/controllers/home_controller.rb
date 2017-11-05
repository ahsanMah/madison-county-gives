class HomeController < ApplicationController
  #include HomeHelper

  def index
  end
  def cart
    @carty = session[:cart]
  end
end
