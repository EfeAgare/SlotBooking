class AvailableSlot < ApplicationRecord
  validates :start, :end, presence: true
  validates :end, presence: true
  validates :generated_at, presence: true

  class << self
    include GenerateTimeSlots
    def compile_time_slots(start, end_time)
      
      start_time =  Time.parse(start)
      finish_time = Time.parse(end_time)

      slots = total_slots(start_time, finish_time)
    end
  end
end
