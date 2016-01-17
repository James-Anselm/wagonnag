class AddLastMaintainedOdometerToMaintenanceItems < ActiveRecord::Migration
  def change
    add_column :maintenance_items, :last_maintained_odometer, :integer
  end
end
