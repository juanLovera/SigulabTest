class AddObservationProject < ActiveRecord::Migration
  def change
  	add_column :projects, :observation, :string
  end
end
