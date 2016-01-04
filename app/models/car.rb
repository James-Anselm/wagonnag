class Car < ActiveRecord::Base
  belongs_to :user
  has_many :maintenence_items, dependent: :destroy
  validates :make, presence: true
  validates :model, presence: true
end
