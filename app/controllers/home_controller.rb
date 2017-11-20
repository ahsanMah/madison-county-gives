class HomeController < ApplicationController
  #include HomeHelper

  def index
  end
  def summary
    @carty = session[:cart]
  end
  def checkout
    @carty = session[:cart]
    @US_states = ["AL", "AK", "AZ", "AR", "CA", "CO", "CT", "DE", "FL", "GA", "HI", "ID", "IL", "IN", "IA", "KS", "KY", "LA", "ME", "MD", "MA", "MI", "MN", "MS", "MO", "NE", "NV", "NH", "NJ", "NM", "NY", "NC", "ND", "OH", "OK", "OR", "PA", "RI", "SC", "TN", "TX", "UT", "VT", "VA", "WA", "WV", "WI", "WY"]
  end
  def processing
     amt = params[:amount_to_cart]
     id = params[:id_to_cart]
     puts "#{amt} ++++++++++++++++ #{id}"
     if amt != nil
       puts "GOT TO SESSION ADDING"
       session[:cart] = {id => amt}
     end
     redirect_to root_path
     return
  end
end
