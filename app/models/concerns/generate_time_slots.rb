module GenerateTimeSlots
  DURATION_IN_MINUTES = 16.freeze

  def total_slots(start_time, finish_time)
    slots = []
    total = number_of_slots(start_time, finish_time)

    start = start_time
    
    1.upto(total) do
      slots << [start.strftime('%l:%M%p').strip, (start + (15 * 60)).strftime('%l:%M%p').strip]
      start = start + (DURATION_IN_MINUTES * 60)
    end

    slots
  end

  def number_of_slots(start, finish)
    (finish.hour - start.hour) * (60 / DURATION_IN_MINUTES)
  end

  def no_slot
    ["No availale slot for this date picked"]
  end
end