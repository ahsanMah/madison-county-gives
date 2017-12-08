class HomeController < ApplicationController
  include HomeHelper
  skip_before_action :verify_authenticity_token, :only => [:processing]

  def index
  end

  def summary
    @empty = 1
    if session[:cart]
      @empty = 0
      carty = session[:cart]
      @names_val = {}
      carty.each do |id, amount|
        @names_val[id] = [Campaign.find(id).name, amount]
      end
    end
  end

  def checkout
    carty = session[:cart]
    @encoded_cart = encode(carty)
    @US_states = ["AL", "AK", "AZ", "AR", "CA", "CO", "CT", "DE", "FL", "GA", "HI", "ID", "IL", "IN", "IA", "KS", "KY", "LA", "ME", "MD", "MA", "MI", "MN", "MS", "MO", "NE", "NV", "NH", "NJ", "NM", "NY", "NC", "ND", "OH", "OK", "OR", "PA", "RI", "SC", "TN", "TX", "UT", "VT", "VA", "WA", "WV", "WI", "WY"]
    @total = 0
    carty.each do |id, amt|
      @total = @total + amt.to_i
    end
    if Rails.env.production? # to make transition from dev to production seamless
      @touchnet_url = "https://test.secure.touchnet.net:8443/C20587test_upay/web/index.jsp"
      @site_id = 4
    else
      @touchnet_url = "https://test.secure.touchnet.net:8443/C20587test_upay/web/index.jsp"
      @site_id = 4
    end
  end

  def add_to_cart
     if session[:cart] == nil
       session[:cart] = {}
     end
     amt = params[:amount_to_cart]
     id = params[:id_to_cart]
     if amt != nil && id != nil
      if amt.to_i > 0
        session[:cart][id] = amt.to_i
      end
     elsif params[:pmt_amt]
     end
     flash[:info] = "Your donation has been successfully added to the cart located in the upper right hand corner."
     byebug
     redirect_to campaign_path(params[:id_to_cart]) and return
  end

  def processing
    if params[:pmt_status] == 'success'
      id_amt = decode(params[:cart])
      id_amt.each do |campaign_id, amount|
        c = ::Campaign.find(campaign_id)
        payment_attributes = {
          :campaign_id => campaign_id,
          :name => params[:name_on_acct],
          :email => params[:acct_email_address],
          :amount => amount,
          :transaction_id => params[:sys_tracking_id],
          :time => DateTime.strptime(params[:pmt_date], "%m/%d/%Y"),
          :is_anonymous => params[:anon],
        }
        c.payments << Payment.create(payment_attributes)
      end
      session[:cart] = nil
      flash[:notice] = "Thank you for your generous contribution!"
    end
  end

  def touchnet_sub # substitute for touchnet during dev
    id_amt = decode(session[:cart])
    id_amt.each do |campaign_id, amount|
      c = ::Campaign.find(campaign_id)
      payment_attributes = {
        :campaign_id => campaign_id,
        :name => params[:BILL_NAME],
        :email => params[:BILL_EMAIL_ADDRESS],
        :amount => amount,
        :transaction_id => 123456,
        :time => DateTime.now,
        :is_anonymous => params[:anon],
      }
      c.payments << Payment.create(payment_attributes)
    end
    session[:cart] = nil
    flash[:notice] = "Thank you for your generous contribution!"
  end

  def remove_donation_cart
    donation_remove = params[:donation_id]
    session[:cart].delete(donation_remove)
    redirect_to summary_path and return
  end
end
