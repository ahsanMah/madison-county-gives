class CampaignChange < ApplicationRecord
	belongs_to :campaign, optional: true
	belongs_to :organization
	has_attached_file :image, :styles=> {:large => "1000x700>", :thumb => "450x300="},
	:default_url => "default.png"
	validates_attachment :image, :content_type => {:content_type =>
	["image/jpeg", "image/png", "image/gif"]}, :size => { less_than: 3.megabytes }

	validates :name, :presence => true
	validates :description, :presence => true
	validates :start_date, :presence => true
	validates :goal, :presence => true, :numericality => { :only_integer => true }
end
