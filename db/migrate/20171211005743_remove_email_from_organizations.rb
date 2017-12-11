class RemoveEmailFromOrganizations < ActiveRecord::Migration[5.1]
  def change
    remove_column :organizations, :email
  end
end
