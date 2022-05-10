class CreateSlots < ActiveRecord::Migration[6.1]
  def change
    create_table :slots, id: :uuid do |t|
      t.datetime :start
      t.datetime :end

      t.timestamps
    end
  end
end
