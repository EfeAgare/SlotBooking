class Api::V1::SlotController < ApplicationController
  before_action :available_slot, if: :slot_params?
  
  def index
    if slot_params?
      if @available_slot.present?
        slots = AvailableSlot.compile_time_slots(
                 Date.parse(params[:date]),  
                 @available_slot.start, @available_slot.end)

         render json: slots, status: :ok
      else
        slots = Slot.compile_time_slots(params[:date])
        render json: slots, status: :ok
      end
    end
  end

  def create
    build_time
    @slot = Slot.new(start: @start, end: @end_time, time_range: @time_range)

    if @slot.save
      render json: @slot, status: :created
    else
      render json: @slot.errors.full_messages.to_sentence, status: :unprocessable_entity
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
    start_hour =  Time.parse(params[:slot]).strftime('%H').to_i
    start_minute = Time.parse(params[:slot]).strftime('%M').to_i

    @start = Date.parse(params[:date]).to_time.change(hour: start_hour, min: start_minute)

    start_time = @start

    duration_in_hour = (start_minute +  params[:duration].to_i) / 60.00

    @end_time = @start + duration_in_hour.hour

    total = (params[:duration].to_i/15.00).ceil ## get the total time slots

    @time_range = []

    1.upto(total) do
      @time_range << start_time.strftime('%l:%M%p').strip
      start_time += (DURATION_IN_MINUTES * 60)
    end

    booked_slot = Slot.booked_slot(Date.parse(params[:date]))

    ## solve booking  time already booked, thereby ignoring duration 
    ## added by user, since the span of the duration has already being 
    ## booked
    @time_range = @time_range -  booked_slot

    # Don't book more than the alloted slot for the day
    index = @time_range.find_index(available_slot.end)

    @time_range = @time_range.slice(0, index+1)  if index.present?
  end
end
