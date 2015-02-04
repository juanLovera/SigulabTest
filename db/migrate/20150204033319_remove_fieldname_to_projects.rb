class RemoveFieldnameToProjects < ActiveRecord::Migration
  def change
    remove_column :projects, :num_cuenta, :integer
  end
end
