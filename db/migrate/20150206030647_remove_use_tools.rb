class RemoveUseTools < ActiveRecord::Migration
  def change
  	remove_column :tools, :use, :string
  end
end
