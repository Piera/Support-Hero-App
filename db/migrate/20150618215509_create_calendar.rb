class CreateCalendar < ActiveRecord::Migration
 def self.up
   create_table :calendars do |t|
	t.datetime :date
	t.integer :heroes_id
	t.integer :starting_orders_id
   end
 end
 
 def self.down
   drop_table :calendars
 end
end
