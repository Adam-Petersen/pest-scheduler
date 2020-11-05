class CreateWorkOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :work_orders do |t|
      t.belongs_to :technician, null: false, foreign_key: true
      t.belongs_to :location, null: false, foreign_key: true
      t.datetime :time
      t.integer :duration
      t.integer :price

      t.timestamps
    end
  end
end
