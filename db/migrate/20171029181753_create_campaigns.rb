class CreateCampaigns < ActiveRecord::Migration[5.1]
  def change
    create_table :campaigns do |t|
      t.integer :organization_id
      t.text :name
      t.text :description
      t.date :start_date
      t.integer :goal
      t.integer :category_id
      t.boolean :is_active
      t.boolean :is_approved
      t.boolean :is_featured

      t.timestamps
    end
  end
end
