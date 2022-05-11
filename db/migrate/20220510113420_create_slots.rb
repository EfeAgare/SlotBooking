class CreateSlots < ActiveRecord::Migration[6.1]
  def change
    create_table :slots, id: :uuid do |t|
      t.datetime :start, null: false
      t.datetime :end, null: false

      t.timestamps
    end
  end
end
