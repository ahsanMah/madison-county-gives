class RemoveFieldCategoryIdFromCampaigns < ActiveRecord::Migration[5.1]
  def change
    remove_column :campaigns, :category_id, :integer
  end
end
