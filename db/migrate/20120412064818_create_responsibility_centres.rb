class CreateResponsibilityCentres < ActiveRecord::Migration
  def change
    create_table :responsibility_centres do |t|
    	t.string :title
    	t.string :description
    	t.text :comment
    	t.integer :head_id

      t.timestamps
    end
  end
end
