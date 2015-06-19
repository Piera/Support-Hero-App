class CreateStartingOrder < ActiveRecord::Migration
 def self.up
   create_table :starting_orders do |t|
   	 t.belongs_to :heroes, index: true
     t.integer :listorder
     t.integer :heroes_id
   end
 end

 def self.down
   drop_table :starting_orders
 end
end
