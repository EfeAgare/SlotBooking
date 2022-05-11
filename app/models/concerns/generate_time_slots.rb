module GenerateTimeSlots
  DURATION_IN_MINUTES = 15.freeze

  def total_slots(start_time, finish_time)
    slots = []
    total = number_of_slots(start_time, finish_time)

    1.upto(total) do
      slots << start_time.strftime('%l:%M%p').strip
      start_time += (DURATION_IN_MINUTES * 60)
    end

    slots
  end

  def number_of_slots(start, finish)
    (finish.hour - start.hour) * (60 / DURATION_IN_MINUTES)
  end
end