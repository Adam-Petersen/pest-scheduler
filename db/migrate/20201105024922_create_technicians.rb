class CreateTechnicians < ActiveRecord::Migration[6.0]
  def change
    create_table :technicians do |t|
      t.string :name

      t.timestamps
    end
  end
end
