class AvailableSlot < ApplicationRecord
  validates :start, :end, presence: true
  validates :end, presence: true
  validates :generated_at, presence: true

  class << self
    include GenerateTimeSlots
    def compile_time_slots(date = nil, start, end_time)
      
      start_time =  Time.parse(start)
      finish_time = Time.parse(end_time)

      booked_slot = []

      booked_slot = Slot.booked_slot(date) if date.present?

      slots = total_slots(start_time, finish_time)

      slots = slots - booked_slot

      slots.present? ? slots : ["No availale slot for this date picked"]
    end
  end
end
