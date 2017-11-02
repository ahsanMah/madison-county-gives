class CreateOrganizations < ActiveRecord::Migration[5.1]
  def change
    create_table :organizations do |t|
      t.integer :user_id
      t.string :name
      t.string :primary_contact
      t.string :address
      t.string :email
      t.text :description
      t.boolean :is_approved

      t.timestamps
    end
  end
end
