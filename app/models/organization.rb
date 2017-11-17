class Organization < ApplicationRecord
  belongs_to :user
  has_many :short_responses
  has_many :campaigns
	has_many :campaign_changes

  has_attached_file :image, :styles=> {:large => "1000x700>", :thumb => "450x300="},
  :default_url => "default.png"
  validates_attachment :image, :content_type => {:content_type =>
  ["image/jpeg", "image/png", "image/gif"]}, :size => { less_than: 3.megabytes }

end
