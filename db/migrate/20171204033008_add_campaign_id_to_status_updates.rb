class AddCampaignIdToStatusUpdates < ActiveRecord::Migration[5.1]
  def change
    add_column :status_updates, :campaign_id, :integer
  end
end
