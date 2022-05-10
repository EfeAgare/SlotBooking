class Api::V1::SlotController < ApplicationController
  def index
    if params[:duration].present?
      binding.pry
      render json: [{id: 1}], status: :ok
    end
  end

  def create
    
  end

  def show

  end
end
