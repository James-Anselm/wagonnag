class MaintenanceItem < ActiveRecord::Base
  belongs_to :car
  validates :name , presence: true
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
