class AddAttachmentImageToOrganizations < ActiveRecord::Migration[4.2]
  def self.up
    change_table :organizations do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :organizations, :image
  end
end
