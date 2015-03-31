class CreateLogtexts < ActiveRecord::Migration
  def change
    create_table :logtexts do |t|
      t.integer :eventtype
      t.string :msg

      t.timestamps
    end
  end
end
