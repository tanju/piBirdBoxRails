class CreateTuersensors < ActiveRecord::Migration
  def change
    create_table :tuersensors do |t|
      t.integer :movetype
      t.timestamp :time

      t.timestamps
    end
  end
end
