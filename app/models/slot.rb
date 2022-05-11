class Slot < ApplicationRecord

  validates :start, :end, presence: true
  validates :end, presence: true

  TIME_NOW = Time.zone.now.freeze

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
        start_time = (TIME_NOW + 15.minute).to_time
      end

      finish_time = Time.parse('17:00')

      slots = total_slots(start_time, finish_time)
      slots.present? ? slots : ["No availale slot for this date picked"]
    end
  end
end
