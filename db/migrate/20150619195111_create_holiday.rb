class CreateHoliday < ActiveRecord::Migration
  def self.up
   create_table :holidays do |t|
	t.datetime :date
	t.string :holidayName
   end
end
 
 def self.down
   drop_table :holidays
 end
end
