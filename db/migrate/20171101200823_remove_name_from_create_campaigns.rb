class RemoveNameFromCreateCampaigns < ActiveRecord::Migration[5.1]
  def change
    remove_column :campaigns, :name, :text
  end
end
