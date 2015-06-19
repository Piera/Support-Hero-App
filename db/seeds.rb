require './app'
require 'date'

support_heroes = [  'Sherry', 'Boris', 'Vicente', 'Matte', 'Jack', 'Sherry', 
					'Matte', 'Kevin', 'Kevin', 'Vicente', 'Zoe', 'Kevin',
					'Matte', 'Zoe', 'Jay', 'Boris', 'Eadon', 'Sherry',
					'Franky', 'Sherry', 'Matte', 'Franky', 'Franky', 'Kevin',
					'Boris', 'Franky', 'Vicente', 'Luis', 'Eadon', 'Boris',
					'Kevin', 'Matte', 'Jay', 'James', 'Kevin', 'Sherry',
					'Sherry', 'Jack', 'Sherry', 'Jack' ]

ca_holidays = { DateTime.new(2015,1,1) => "New Year’s Day", 
				DateTime.new(2015,1,19) => "Martin Luther King Jr. Day",
				DateTime.new(2015,2,16) => "Presidents’ Day",
				DateTime.new(2015,3,31) => "Cesar Chavez Day",
				DateTime.new(2015,5,25) => "Memorial Day",
				DateTime.new(2015,7,6) =>  "Independence Day",
				DateTime.new(2015,9,7) =>  "Labor Day",
				DateTime.new(2015,11,11) => "Veterans Day",
				DateTime.new(2015,11,26) => "Thanksgiving Day",
				DateTime.new(2015,11,27) => "Day after Thanksgiving",
				DateTime.new(2015,12,25) => "Christmas Day" }

# Seed Hero Ids		
heroes_list = Array.new
support_heroes.each do |person|
	heroes_list.push(person) if not heroes_list.include?(person)
	Hero.create!( name: person) unless Hero.where( name: person ).first
end
puts heroes_list

# Seed Hero Starting Order
n = 1
support_heroes.each do |person|
	next_hero = Hero.find_by name: person
	puts next_hero.name
	StartingOrder.create!( heroes_id: next_hero.id, listorder: n )
	n += 1
end 

# Seed CA Holidays
ca_holidays.each do |date, holidayName|
	Holiday.create!( date: date, holidayName: holidayName ) unless Holiday.where( date: date ).first
	puts Holiday.name
end









	




