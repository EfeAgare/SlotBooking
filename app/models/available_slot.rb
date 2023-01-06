class AvailableSlot < ApplicationRecord
  validates :start, :end, presence: true
  validates :end, presence: true
  validates :generated_at, presence: true

  class << self
    include GenerateTimeSlots
    include ::Api::V1::SlotHelper
    
    def compile_time_slots(date = nil, start, end_time)
      
      start_time =  Time.parse(start)
      finish_time = Time.parse(end_time)

      booked_slot = []

      booked_slot = NewSlot.booked_slot(date) if date.present?
      
      booked_slot =  booked_slot.map {|time| [format_time(time[0]), format_time(time[1])]}

      slots = total_slots(start_time, finish_time)
      
      connected_slots = []

      slots.each do |slot|
        booked_slot.each do |booked|
          if (booked[0] < slot[1]) && (booked[1] > slot[0])
            connected_slots << slot
          end
        end
      end

      slots = slots - connected_slots

      slots.present? ? slots : ["No availale slot for this date picked"]
    end
  end
end
