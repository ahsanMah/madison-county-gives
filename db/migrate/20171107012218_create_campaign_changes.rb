class CreateCampaignChanges < ActiveRecord::Migration[5.1]
  def change
    create_table :campaign_changes do |t|
      t.integer :campaign_id
      t.string :name
      t.text :description
      t.date :start_date
      t.integer :goal
      t.string :action

      t.timestamps
    end
  end
end
