class MaintenanceItem < ActiveRecord::Base
  belongs_to :car
  validates :name , presence: true
  validates :interval, presence: true
end
