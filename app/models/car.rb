class Car < ActiveRecord::Base
  belongs_to :user
  validates :make, presence: true
  validates :model, presence: true
end
