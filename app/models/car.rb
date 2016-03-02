class Car < ActiveRecord::Base
  belongs_to :user
  has_many :maintenance_items, dependent: :destroy
  validates :make, presence: true
  validates :model , presence: true
  validates :odometer, presence: true

  def get_expired_maintenance_items
    return self.maintenance_items.where("due_for_checkup = 't'")
  end
end
