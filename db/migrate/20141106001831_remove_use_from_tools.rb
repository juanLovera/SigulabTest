class RemoveUseFromTools < ActiveRecord::Migration
  def change
    remove_column :tools, :use, :string
  end
end
