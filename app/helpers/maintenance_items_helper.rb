module MaintenanceItemsHelper
  def expired_maintenance_items(user_id)
    return MaintenanceItem.where("due_for_checkup = 't'")
               .joins(:car => :user).where("users.id = ?", user_id)
  end
end
