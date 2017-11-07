class AddAttachmentImageToCampaignChanges < ActiveRecord::Migration[4.2]
  def self.up
    change_table :campaign_changes do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :campaign_changes, :image
  end
end
