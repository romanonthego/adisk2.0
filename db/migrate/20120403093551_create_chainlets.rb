class CreateChainlets < ActiveRecord::Migration
  def change
    create_table :chainlets do |t|
    	t.string :title
    	t.string :description
    	t.text :comment
      t.timestamps
    end
  end
end
