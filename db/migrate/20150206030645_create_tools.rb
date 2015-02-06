class CreateTools < ActiveRecord::Migration
  def change
    create_table :tools do |t|
      t.string :name
      t.string :brand
      t.string :type
      t.integer :national_good
      t.string :status
      t.string :use
      t.string :responsible
      t.string :location
      t.string :material
      t.string :bill
      t.boolean :from_set
      t.boolean :investigation
      t.boolean :teaching
      t.boolean :extention
      t.boolean :management

      t.timestamps
    end
  end
end
