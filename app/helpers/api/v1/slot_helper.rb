module Api::V1::SlotHelper
  def format_time(time)
    DateTime.parse(time.to_s).strftime('%H:%M%p').strip
  end
end
