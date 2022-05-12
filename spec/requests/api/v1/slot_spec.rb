require 'rails_helper'

RSpec.describe "Api::V1::Slots", type: :request do

  describe "#index" do
    let(:date) { Time.zone.tomorrow }
    let(:duration) { 40 }

    subject { get "/api/v1/slot", params: { date: date, 
      duration: duration, format: "application/json" }
    }

    context "when no available plan exist" do
      it "returns http success" do
        subject

        expect(response).to have_http_status(:success)
      end

      it "returns the available slots" do
        subject

        expect(JSON.parse(response.body)).not_to be_nil
        expect(JSON.parse(response.body)).to include("8:00AM")
      end
    end
  end

  describe "#create" do
    let(:date) { Time.zone.tomorrow }
    let(:duration) { 40 }
    let(:slot) {"9:00AM" }
    
    subject { post "/api/v1/slot", params: { date: date, 
      duration: duration, slot: slot, format: "application/json" } }

    before do
      AvailableSlot.create(start: "8:00AM", end: "4:45PM", generated_at: date)
    end

    it "returns http success" do
      
      subject

      expect(response).to have_http_status(:success)
    end

    it "returns the slots base on the duration" do
      subject
     
      expect(JSON.parse(response.body)["time_range"]).to include("9:00AM")
      expect(JSON.parse(response.body)["time_range"]).to include("9:15AM")
      expect(JSON.parse(response.body)["time_range"]).to include("9:30AM")
    end
  end
end
