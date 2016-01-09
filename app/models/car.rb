class Car < ActiveRecord::Base
  belongs_to :user
  has_many :maintenance_items, dependent: :destroy
  validates :make, presence: true
  validates :model , presence: true
end
