class AddDueForCheckupToMaintenanceItem < ActiveRecord::Migration
  def change
    add_column :maintenance_items, :due_for_checkup, :boolean, default: false
  end
end
