class Slot < ApplicationRecord
  validates :start, :end, presence: true
  validates :end, presence: true
  validates :time_range, presence: true

  TIME_NOW = Time.zone.now.freeze

  scope :booked_slot, -> (date) do
    where('start BETWEEN :start_date AND :end_date',   {
        start_date: date.beginning_of_day,
        end_date: date.end_of_day
      }).pluck(:time_range)&.flatten&.uniq
  end

  class << self
    include GenerateTimeSlots
    #   DURATION_IN_MINUTES = 15
    #
    #   start-time = 8:00
    #   finish-time = 17:00
    #   60 / 15 = 4 
    #   (17 - 8) * 4 = 36 time slots
    #

    def compile_time_slots(date)
      # use time.now to not create slot for past
      # time of the day and step the time forward 
      # by 30 minutes
      
      if Time.parse(date).to_time  > Time.zone.now
        ## cater for booking at 12am - 8am
        start_time = Time.parse('8:00')
      else
        start_time = TIME_NOW > Time.parse('8:00') ?  (TIME_NOW + 15.minute).to_time : Time.parse('8:00')
      end

      finish_time = Time.parse('17:00')

      slots = total_slots(start_time, finish_time)
      AvailableSlot.create(start: slots.first, end: slots.last, generated_at: Date.parse(date)) if slots.present?
      slots.present? ? slots : ["No availale slot for this date picked"]
    end
  end
end
