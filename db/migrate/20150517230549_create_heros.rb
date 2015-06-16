class CreateHeros < ActiveRecord::Migration
 def self.up
   create_table :heros do |h|
     h.string :name
     h.datetime :schedule_date
     h.integer :order
   end
 end

 def self.down
   drop_table :heros
 end
end