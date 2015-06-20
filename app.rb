require 'sinatra'
require 'sinatra/activerecord'
require 'environments'
require 'sinatra/flash'
require 'sinatra/redirect_with_flash'
require 'rack/utils'
require 'date'

enable :sessions

class Hero < ActiveRecord::Base
	self.table_name = "heroes"
	has_many :starting_orders
 	validates :name, presence: true
end

class StartingOrder < ActiveRecord::Base
	belongs_to :heroes
	validates :listorder, presence: true
	validates :heroes_id, presence: true
end

class Calendar < ActiveRecord::Base
	has_many :heroes
	has_many :holidays
	has_many :unavailables
	validates :date, presence: true
	validates :heroes_id, presence: true
end

class Holiday < ActiveRecord::Base
	belongs_to :calendars
	validates :date, presence: true
	validates :holidayName, presence: true
end

class Unavailable < ActiveRecord::Base
	belongs_to :calendars
	belongs_to :heroes
	validates :date, presence: true
	validates :heroes_id, presence: true
end

#schedule view
get '/' do 
	@heroes = Hero.order('id ASC')
	@month = CreateSchedule.new.month(2015,6,1)
	@month_range = CreateSchedule.new.month_range(2015,6,1)
	erb :index
end

#roster view
get '/heroes' do
	@heroes = Hero.order('schedule_date ASC')
	erb :hero
end

#hero profile views
get '/:id' do
 	@hero = Hero.find(params[:id])
	erb :profile
end

#switch two hero schedule_dates
post '/switch' do
	hero1 = Hero.find(params[:id][0])
	hero2 = Hero.find(params[:id][1])
	HeroSwitch.new.date_update(hero1, hero2)
	redirect "/heroes"
end

# --------------------------------------------

# Switch two Hero's support days
class HeroSwitch
	def date_update(hero1, hero2)
		date1 = hero1.schedule_date
		date2 = hero2.schedule_date
		hero1.update(schedule_date: date2)
		hero2.update(schedule_date: date1)
	end
end

# Define Month ranges; a range that is either the full or remainder of month
# Something glitchy in here to fix...
class Month
	def month_start(d = Time.now)
		year = d.strftime('%Y').to_i
		month = d.strftime('%m').to_i
		day = 1.to_i
	end
	def remainder_month_start(d = Time.now)
		year = d.strftime('%Y').to_i
		month = d.strftime('%m').to_i
		day = d.strftime('%d').to_i
	end
	def month_range(year = 2015, month = 6, day = 1)
		begin_date = Date.new(year, month, day)
		end_date = Date.new(year, month, -1)
		month_range = (begin_date .. end_date)
	end
end

class CreateSchedule
# For the current or selected month:
	def new_month_schedule(month_range = Month.new.month_range)
		n = 1
		month_range.each do |d|
			# Check that date is not a weekend and checks that date is not a holiday
			if d.wday != 6 or d.wday != 0 and Holiday.where( :date => d ).blank? 
			# Resets starting order when it reaches end
				if StartingOrder.find_by( listorder: n ).blank? 
					n = 1
				end
				# Finds the next hero based on starting order
				scheduled_hero = StartingOrder.find_by( listorder: n  )
				# Find an available hero:
				while not Unavailable.find_by( date: d, heroes_id: scheduled_hero.id ).blank?
					n += 1
					# Resets starting order when it reaches end of listorder
					if StartingOrder.find_by( listorder: n ).blank? 
						n = 1
					end
					scheduled_hero = StartingOrder.find_by( listorder: n )
				end
				# Create calendar entry!
				Calendar.create!( heroes_id: scheduled_hero.heroes_id, date: d )
				# Increment the counter for the hero listorder
				n += 1
			end
		end
	end
end


# Psuedocode for updating current month schedule:
# For the current or selected month, starting with the day after the affected date,
# and continuting to end of month: 
# Iterate through the hero order, and create a record in calendars that:
#   assigns each hero in order to the days of the month
# 	Unless the date is a weekend
# 	Unless the date is a holiday
# 	Unless the hero is unavailable

# Pseudocode for generating next month schedule:
# For the next month:
# Iterate through the hero order, starting with the next hero in order based on last 
# hero in previous month, and create a record in calendars that:
#   assigns each hero in order to the days of the month
# 	Unless the date is a weekend
# 	Unless the date is a holiday
# 	Unless the hero is unavailable

