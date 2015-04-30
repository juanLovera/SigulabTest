class QuitarSpecid < ActiveRecord::Migration
  def change
  	remove_column :requisitions, :specification_id, :integer
  end
end
