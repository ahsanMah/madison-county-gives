class HomeController < ApplicationController
  #include HomeHelper

  def index
  end
  def summary
    carty = session[:cart]
    @names_val = {}
    carty.each do |id, val|
      @names_val[Campaign.find(id).name] = val
    end
  end
  def checkout
    @carty = session[:cart]
    @US_states = ["AL", "AK", "AZ", "AR", "CA", "CO", "CT", "DE", "FL", "GA", "HI", "ID", "IL", "IN", "IA", "KS", "KY", "LA", "ME", "MD", "MA", "MI", "MN", "MS", "MO", "NE", "NV", "NH", "NJ", "NM", "NY", "NC", "ND", "OH", "OK", "OR", "PA", "RI", "SC", "TN", "TX", "UT", "VT", "VA", "WA", "WV", "WI", "WY"]
    @total = 0
    @carty.each do |id, amt|
      @total = @total + amt.to_i
    end
  end
  def processing
     amt = params[:amount_to_cart]
     id = params[:id_to_cart]
     puts "#{amt} ++++++++++++++++ #{id}"
     if amt != nil
       if session[:cart][id]
         session[:cart][id] = (session[:cart][id].to_i + amt.to_i).to_s
       else
         session[:cart][id] = amt
     end
     elsif params[:pmt_amt]
       puts "touchnet posted back"
     end
     redirect_to root_path
     return
  end

  def create_payment #potential to DRY via params require permit???
    if params[:pmt_status]
      name = params[:name_on_acct]
      email = params[:acct_email_address]
      phone = params[:acct_phone_day]
      amount = params[:pmt_amt]
      transaction_id = params[:sys_tracking_id]
      time = DateTime.strptime(params[:pmt_date].to_s, "%m/%d/%Y")
      anon = params[:anon]
      kono = params[:sponsored]
      split_payment = params[:pay_split]
      split_payment.each |campaign_id, amount| do 
        c = Campaigns.find(campaign_id)
        c.payments << Payment.create(campaign_id, name, email, phone, amount, transaction_id, time, anon, kono)
      end
      flash[:notice] = "Thank you for your generous contribution!"
    end
  end
end

