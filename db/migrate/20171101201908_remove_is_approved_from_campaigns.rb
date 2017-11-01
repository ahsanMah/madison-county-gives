class RemoveIsApprovedFromCampaigns < ActiveRecord::Migration[5.1]
  def change
    remove_column :campaigns, :is_approved, :boolean
  end
end
