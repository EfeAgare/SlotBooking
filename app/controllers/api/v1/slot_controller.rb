class Api::V1::SlotController < ApplicationController
  def index
    if slot_params?
      if available_slot.present?
        slots = AvailableSlot.compile_time_slots(available_slot.start, 
                    available_slot.end)
         render json: slots, status: :ok
      else
        slots = Slot.compile_time_slots(params[:date])
        render json: slots, status: :ok
      end
    end
  end

  def create

  end

  def show

  end

  private

  def slot_params?
    params[:duration].present? && params[:date].present?
  end

  def available_slot
    AvailableSlot.find_by(generated_at: Date.parse(params[:date]))
  end
end
