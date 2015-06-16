require 'date'

class Hero
	attr_accessor :name 
	def initialize(name)
		@name = name.to_s
	end

	def talk
		puts "Hey I'm talking now!"
	end
end



Jane = Hero.new("Jane")
puts Jane.talk
puts Jane.name


class Schedule
	attr_accessor :month, :holidays
	def initialize(month, holidays)
		@month = DateTime.new(2015,5,4)
		@holidays = holidays
	end
end

May = Schedule.new("May", "May 5")

puts May.month
puts May.holidays




# Objects:

# Month
# 	Attributes:
# 		holidays
# 	Methods:
# 		exclude_date
# 		swap_heros

# Hero
# 	Attributes:
# 		name
# 	Schedule




