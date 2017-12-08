class StatusUpdateChangeTypeForTime < ActiveRecord::Migration[5.1]
  def change
  	remove_column :status_updates, :time, :time

  	add_column :status_updates, :date, :date
  end
end
