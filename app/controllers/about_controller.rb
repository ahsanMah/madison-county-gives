class AboutController < ApplicationController

  def about_us
    render 'about_us'
  end

  def faqs
    render 'faqs'
  end

  def contact_us
    render 'contact_us'
  end
  
end
