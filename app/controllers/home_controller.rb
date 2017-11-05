class HomeController < ApplicationController
  #include HomeHelper

  def index
  end
  def summary
    @carty = session[:cart]
  end
  def checkout
  end
end
