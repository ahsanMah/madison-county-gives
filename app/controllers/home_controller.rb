class HomeController < ApplicationController
  #include HomeHelper

  def index
    flash[:alert] = "flash[:alert] testing"
    flash[:notice] = "flash[:notice] testing"
    flash[:success] = "flash[:success] testing"
    flash[:error] = "flash[:error] testing"
  end
end
