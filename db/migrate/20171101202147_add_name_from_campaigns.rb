class AddNameFromCampaigns < ActiveRecord::Migration[5.1]
  def change
    add_column :campaigns, :name, :string
  end
end
