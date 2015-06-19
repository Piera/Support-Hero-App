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
	validates :date, presence: true
	validates :heroes_id, presence: true
end

class Holiday < ActiveRecord::Base
	belongs_to :calendars
	validates :date, presence: true
	validates :holidayName, presence: true
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
end
