require 'rails_helper'

RSpec.describe NewSlot, type: :model do
  describe 'validation' do
    it { should validate_presence_of(:start) }
    it { should validate_presence_of(:stop) }
  end
end
