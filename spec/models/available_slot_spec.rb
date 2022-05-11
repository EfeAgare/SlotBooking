require 'rails_helper'

RSpec.describe AvailableSlot, type: :model do
  describe 'validation' do
    it { should validate_presence_of(:start) }
    it { should validate_presence_of(:end) }
    it { should validate_presence_of(:generated_at) }
  end
end
