class Campaign < ApplicationRecord
  has_one :campaign_change
  has_many :payments
  belongs_to :organization
  has_many :payments
  has_attached_file :image, :styles=> {:large => "1000x700>", :thumb => "450x300="},
  :default_url => "default.png"
  validates_attachment :image, :content_type => {:content_type =>
  ["image/jpeg", "image/png", "image/gif"]}, :size => { less_than: 3.megabytes }

  attr_accessor :amount_raised, :percent_raised
end
