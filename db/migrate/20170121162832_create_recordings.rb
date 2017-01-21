class CreateRecordings < ActiveRecord::Migration[5.0]
  def change
    create_table :recordings do |t|
      t.integer :temp
      t.string :status

      t.references :location

      t.timestamps
    end
  end
end
