class Api::V1::NewSlotController < ApplicationController
  before_action :available_slot, if: :slot_params?
  
  def index
    if slot_params?
      if @available_slot.present?
        slots = AvailableSlot.compile_time_slots(
                 Date.parse(params[:date]),  
                 @available_slot.start, @available_slot.end)

         render json: slots, status: :ok
      else
        slots = NewSlot.compile_time_slots(params[:date])
        render json: slots, status: :ok
      end
    end
  end

  def create
    build_time

    if @check_scheduling_conflict
      render json: ["Can't schedule, possible duration extends already taken minutes"], status: :created
    else
      @slot = NewSlot.new(start: @start, stop: @end_time)

      if @slot.save
        render json: [format_time(@slot.start), format_time(@slot.stop)], status: :created
      else
        render json: @slot.errors.full_messages.to_sentence, status: :unprocessable_entity
      end
    end
  end

  private

  def slot_params?
    params[:duration].present? && params[:date].present?
  end

  def available_slot
    @available_slot ||= AvailableSlot.find_by(generated_at: Date.parse(params[:date]))
  end

  def build_time
    start_hour = Time.parse(params[:slot]).strftime('%H').to_i
    start_minute = Time.parse(params[:slot]).strftime('%M').to_i

    @start = Date.parse(params[:date]).to_time.change(hour: start_hour, min: start_minute)

    start_time = @start

    duration_in_hour = (params[:duration].to_i) / 60.00

    @end_time = @start + duration_in_hour.hour

    total = (params[:duration].to_i/15.00).ceil ## get the total time slots

    booked_slot = NewSlot.booked_slot(Date.parse(params[:date]))

    booked_slot =  booked_slot.map {|time| [format_time(time[0]), format_time(time[1])]}

    added_slot = [format_time(start_time), format_time(@end_time)]

    @check_scheduling_conflict = check_scheduling_conflict(added_slot, booked_slot)
  end

  def check_scheduling_conflict(new_shift, shifts)
    shifts.each do |shift|
      # Check for non-empty intersection between shifts
      if (new_shift[0] < shift[1]) && (new_shift[1] > shift[0])
        return true
      end
    end
    return false
  end
end
