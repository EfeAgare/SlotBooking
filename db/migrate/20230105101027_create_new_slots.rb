class CreateNewSlots < ActiveRecord::Migration[6.1]
  def change
    create_table :new_slots, id: :uuid do |t|
      t.datetime :start
      t.datetime :stop

      t.timestamps
    end
  end
end
