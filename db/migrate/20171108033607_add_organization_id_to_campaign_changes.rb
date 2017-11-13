class AddOrganizationIdToCampaignChanges < ActiveRecord::Migration[5.1]
  def change
    add_column :campaign_changes, :organization_id, :integer
  end
end
