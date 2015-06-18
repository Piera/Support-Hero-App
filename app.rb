require 'sinatra'
require 'sinatra/activerecord'
require 'environments'
require 'sinatra/flash'
require 'sinatra/redirect_with_flash'
require 'rack/utils'
require 'date'

enable :sessions

class Hero < ActiveRecord::Base
	has_many :starting_orders
 	validates :name, presence: true
end

class StartingOrder < ActiveRecord::Base
	belongs_to :hero
	validates :order, presence: true
	validates :heroes_id, presence: true
end

#schedule view
get '/' do 
	@heroes = Hero.order('schedule_date ASC')
	@month = CreateSchedule.new.month(2015,6,1)
	@month_range = CreateSchedule.new.month_range(2015,6,1)
	@seed_calendar = CreateSchedule.new.seed_calendar(@month_range)
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
		n = 0
		month_range.each do |d, name, order|
			if d.wday == 6 or d.wday == 0
				puts "Weekend!"
				next
			else

				order = n + 1
				Hero.create( name:  hero_order[n], order: order )
				puts Hero.name
				n += 1
		end
	end
end


end



