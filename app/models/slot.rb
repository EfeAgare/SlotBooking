class Slot < ApplicationRecord

  validates :start, :end, presence: true
  validates :end, presence: true
end
