class CreateAvailableSlots < ActiveRecord::Migration[6.1]
  def change
    create_table :available_slots, id: :uuid do |t|
      t.string :start, null: false
      t.string :end, null: false
      t.datetime :generated_at, null: false, index: { unique: true }

      t.timestamps
    end
  end
end
