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
				DateTime.new(2015,7,6) =>  "Independence Day Observed",
				DateTime.new(2015,9,7) =>  "Labor Day",
				DateTime.new(2015,11,11) => "Veterans Day",
				DateTime.new(2015,11,26) => "Thanksgiving Day",
				DateTime.new(2015,11,27) => "Day after Thanksgiving",
				DateTime.new(2015,12,25) => "Christmas Day" }

# Seed HEROES	
puts "--------HEROES------"
puts "--------------------"
heroes_list = Array.new
support_heroes.each do |person|
	heroes_list.push(person) if not heroes_list.include?(person)
	Hero.create!( name: person) unless Hero.where( name: person ).first
end
puts heroes_list

# Seed HERO STARTING ORDER 
puts "--------ORDER-------"
puts "--------------------"
n = 1
support_heroes.each do |person|
	next_hero = Hero.find_by name: person
	StartingOrder.create!( heroes_id: next_hero.id, listorder: n ) unless StartingOrder.where( listorder: n ).first
	puts n
	check_hero = StartingOrder.find_by( listorder: n )
	puts "Starting Order #{check_hero.listorder}"
	puts "Hero id #{check_hero.heroes_id}"
	n += 1
end 

# Seed HOLIDAYS
puts "-----HOLIDAYS-------"
puts "--------------------"
ca_holidays.each do |date, holidayName|
	Holiday.create!( date: date, holidayName: holidayName ) unless Holiday.where( date: date ).first
	holiday = Holiday.find_by( holidayName: holidayName )
	puts holiday.holidayName
end

# Seed a few UNAVAILABLE DATE for development purposes; delete for production
puts "-----UNAVAILABLE----"
puts "--------------------"
Unavailable.create!( date: DateTime.new(2015,6,30), heroes_id: 3 ) unless Unavailable.where( date: DateTime.new(2015,6,30), heroes_id: 3 ).first
Unavailable.create!( date: DateTime.new(2015,6,29), heroes_id: 4 ) unless Unavailable.where( date: DateTime.new(2015,6,29), heroes_id: 4 ).first
Unavailable.create!( date: DateTime.new(2015,6,29), heroes_id: 10 ) unless Unavailable.where( date: DateTime.new(2015,6,29), heroes_id: 10 ).first
unavailable1 = Unavailable.find_by( heroes_id: 3, date: DateTime.new(2015,6,30) )
unavailable1 = Unavailable.find_by( heroes_id: 3, date: DateTime.new(2015,6,30) )
puts unavailable1.date
puts unavailable1.heroes_id
unavailable2 = Unavailable.find_by( heroes_id: 4, date: DateTime.new(2015,6,29) )
puts unavailable2.date
puts unavailable2.heroes_id
unavailable3 = Unavailable.find_by( heroes_id: 10, date: DateTime.new(2015,6,29) )
puts unavailable3.date
puts unavailable3.heroes_id

# Seed JUNE CALENDAR for development purposes; won't be needed for production
puts "-----SCHEDULE-------"
puts "--------------------"
CreateSchedule.new.new_month_schedule










	




