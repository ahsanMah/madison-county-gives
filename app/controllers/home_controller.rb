class HomeController < ApplicationController
  #include HomeHelper

  def index
  end
  def summary
    @empty = 1
    if session[:cart]
      @empty = 0
      carty = session[:cart]
      @names_val = {}
      carty.each do |id, val|
        @names_val[Campaign.find(id).name] = val
      end
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
     if session[:cart] == nil
       session[:cart] = {}
     end
     amt = params["amount_to_cart"]
     id = params["id_to_cart"]
     if amt != nil && id != nil
       session[:cart][id] = amt
     elsif params[:pmt_amt]
     end
     redirect_to root_path
     return
  end

  def create_payment # can we use params require permit here?
    if params[:pmt_status] == 'success'
      params[:pay_split].each do |campaign_id, amount|
        kono = false 
        c = ::Campaign.find(campaign_id)
        if c.is_featured
          kono = true
        end
        payment_attributes = {
          :campaign_id => campaign_id,
          :name => params[:name_on_acct],
          :email => params[:acct_email_address],
          :phone => params[:acct_phone_day],
          :amount => amount,
          :transaction_id => params[:sys_tracking_id],
          :time => DateTime.strptime(params[:pmt_date].to_s, "%m/%d/%Y"),
          :is_anonymous => params[:anon],
          :is_konosioni => kono
        }
        c.payments << Payment.create(payment_attributes)
      end
      flash[:notice] = "Thank you for your generous contribution!"
    end
  end
end