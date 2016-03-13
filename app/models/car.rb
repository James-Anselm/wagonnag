class Car < ActiveRecord::Base
  belongs_to :user
  has_many :maintenance_items, dependent: :destroy
  validates :make, presence: true
  validates :model , presence: true
  validates :odometer, presence: true

  def get_expired_maintenance_items
    return self.maintenance_items.where("due_for_checkup = 't'")
  end

  def get_display_name
    if(self.nickname != nil)
      return self.nickname
    else
      return self.year + ' ' + self.make + ' ' + self.model
    end
  end
end
