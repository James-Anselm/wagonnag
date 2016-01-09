class CreateMaintenanceItems < ActiveRecord::Migration
  def change
    create_table :maintenance_items do |t|
      t.string :name
      t.references :car, index: true, foreign_key: true
      t.string :description
      t.integer :interval

      t.timestamps null: false
    end
  end
end
