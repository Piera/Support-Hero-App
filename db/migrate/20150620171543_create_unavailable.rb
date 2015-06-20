class CreateUnavailable < ActiveRecord::Migration
  def self.up
   create_table :unavailables do |t|
	t.datetime :date
	t.integer :heroes_id
   end
end
 
 def self.down
   drop_table :unavailables
 end
end
