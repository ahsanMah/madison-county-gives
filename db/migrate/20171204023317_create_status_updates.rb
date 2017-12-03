class CreateStatusUpdates < ActiveRecord::Migration[5.1]
  def change
    create_table :status_updates do |t|
      t.text :text
      t.time :time

      t.timestamps
    end
  end
end
