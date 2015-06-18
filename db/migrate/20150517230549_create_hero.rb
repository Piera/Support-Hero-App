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


