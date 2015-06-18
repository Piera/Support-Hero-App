class CreateHero < ActiveRecord::Migration
 def self.up
   create_table :heroes do |t|
     t.string :name
   end
 end

 def self.down
   drop_table :heroes
 end
end

class CreateStarting_order < ActiveRecord::Migration
 def self.up
   create_table :starting_orders do |t|
   	 t.belongs_to :hero, index: true
     t.integer :order
     t.integer :heroes_id
   end
 end

 def self.down
   drop_table :startingOrders
 end
end

