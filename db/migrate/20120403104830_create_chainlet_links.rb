class CreateChainletLinks < ActiveRecord::Migration
  def change
    create_table :chainlet_links do |t|
    	t.integer :chainlet_id
    	t.integer :ordinal_number, :nill => false
    	t.string :link_type
    	t.string :link_value
    	t.integer :timeout
      t.timestamps
    end
  end
end
