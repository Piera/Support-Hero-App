require 'sinatra'
require 'sinatra/activerecord'
require 'environments'
require 'sinatra/flash'
require 'sinatra/redirect_with_flash'
require 'rack/utils'
require 'date'

enable :sessions

class Heros < ActiveRecord::Base
 	validates :name, presence: true
 	validates :order, presence: true
 	validates :schedule_date, presence:true
end

#schedule view
get '/' do 
	@heros = Heros.order('schedule_date ASC')
	@month = CreateSchedule.new.month(2015,6,1)
	@month_range = CreateSchedule.new.month_range(2015,6,1)
	@seed = CreateSchedule.new.seed_calendar(@month_range)
	erb :index
end

#roster view
get '/heros' do
	@heros = Heros.order('schedule_date ASC')
	erb :hero
end

#hero profile views
get '/:id' do
 	@hero = Heros.find(params[:id])
	erb :profile
end

#switch two hero schedule_dates
post '/switch' do
	hero1 = Heros.find(params[:id][0])
	hero2 = Heros.find(params[:id][1])
	HeroSwitch.new.date_update(hero1, hero2)
	redirect "/heros"
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

# Create a new month schedule
class CreateSchedule
	def month(year, month, day)
		d = Date.civil(year, month, day)
		month = d.strftime('%b')
	end
	def month_range(year, month, day)
		begin_date = Date.new(year, month, day)
		end_date = Date.new(year, month, -1)
		month_range = (begin_date .. end_date)
	end
	def seed_calendar(month_range)
		hero_order = ['Sherry', 'Boris', 'Vicente', 'Matte', 'Jack', 'Sherry',
					'Matte', 'Kevin', 'Kevin', 'Vicente', 'Zoe', 'Kevin',
					'Matte', 'Zoe', 'Jay', 'Boris', 'Eadon', 'Sherry',
					'Franky', 'Sherry', 'Matte', 'Franky', 'Franky', 'Kevin',
					'Boris', 'Franky', 'Vicente', 'Luis', 'Eadon', 'Boris',
					'Kevin', 'Matte', 'Jay', 'James', 'Kevin', 'Sherry',
					'Sherry', 'Jack', 'Sherry', 'Jack']
		seeded = Hash.new
		n = 0
		month_range.each do |d|
			puts d.wday
			if d.wday == 6
				seeded[:d] = "Weekend"
				puts seeded[:d]
			elsif d.wday == 0
				seeded[:d] = "Weekend"
				puts seeded[:d]
			else
				seeded[:d] = hero_order[n]
				puts seeded[:d]
				n += 1
		end
	end
end



# Update a schedule
# class UpdateSchedule
# 	def update_month(month)
# 	end
end

