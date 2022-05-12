class AddTimeRangeToSlot < ActiveRecord::Migration[6.1]
  def change
    add_column :slots, :time_range, :string, array:true, default: []
  end
end
