require 'rails_helper'

RSpec.describe Slot, type: :model do
  describe 'validation' do
    it { should validate_presence_of(:start) }
    it { should validate_presence_of(:end) }
  end
end
