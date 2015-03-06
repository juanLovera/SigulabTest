class CreateRelationServiceItem < ActiveRecord::Migration
  def change
    create_table :service_items do |t|
    	t.string	"servicio"
    	t.string	"item"
    	t.datetime  "created_at"
	    t.datetime  "updated_at"
	    t.timestamps
    end
  end
end
