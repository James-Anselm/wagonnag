class Car < ActiveRecord::Base
  belongs_to :user
  has_many :maintenance_items, dependent: :destroy
  validates :make,
            presence: true,
            length: {
                maximum: 32
            }
  validates :model,
            presence: true,
            length: {
                maximum: 32
            }
  validates :year,
            numericality: {
                allow_blank: true,
                allow_nil: true,
                greater_than_or_equal_to: 1900,
                less_than_or_equal_to: Date.today.year + 1 # +1 to allow for models that are often set for the following year (ie. 2016 Honda Civic in September 2015)
            }
  validates :nickname,
            length: {
                maximum: 32
            }
  validates :odometer,
            presence: true,
            numericality: {
                only_integer: true,
                greater_than_or_equal_to: 0
            }

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
