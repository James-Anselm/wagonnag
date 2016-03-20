class MaintenanceItem < ActiveRecord::Base
  belongs_to :car
  validates :name,
            presence: true,
            length: {
                maximum: 32
            }
  validates :interval,
            numericality: {
                only_integer: true,
                greater_than_or_equal_to: 0,
                allow_blank: true,
                allow_nil: true
            }
  validates :last_maintained_odometer,
            numericality:  {
                only_integer: true,
                greater_than_or_equal_to: 0,
                allow_blank: true,
                allow_nil: true
            }

  before_save :check_due_for_checkup

  def update_due_for_checkup(due_for_checkup)
    update_attribute(:due_for_checkup, due_for_checkup)
  end

  private

    def check_due_for_checkup
      if(self.last_maintained_odometer &&
        self.interval &&
        self.last_maintained_odometer + self.interval > self.car.odometer)
        self.due_for_checkup = false
      end
      return true ## without this statement, this method would return false and mess up saving.
    end
end
