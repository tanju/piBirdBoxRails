class CreateCpuTemperatures < ActiveRecord::Migration
  def change
    create_table :cpu_temperatures do |t|
      t.timestamp :time
      t.integer :temperature

      t.timestamps
    end
  end
end
