class NewSlot < ApplicationRecord
  validates :start, presence: true
  validates :stop, presence: true
  
  TIME_NOW = Time.zone.now.freeze

  scope :booked_slot, -> (date) do
    where('start::date = ?', date).pluck(:start, :stop)
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

      return no_slot if Date.parse(date) < Date.current

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

      booked_slot = NewSlot.booked_slot(date) if date.present?
      
      booked_slot =  booked_slot.map {|time| [format_time(time[0]), format_time(time[1])]}

      slots = total_slots(start_time, finish_time)
      
      AvailableSlot.create(start: slots.first, end: slots.last, generated_at: Date.parse(date)) if slots.present?
      slots.present? ? slots : no_slot
    end
  end
end
