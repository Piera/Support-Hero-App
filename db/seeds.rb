require './app'

support_heroes = ['Sherry', 'Boris', 'Vicente', 'Matte', 'Jack', 'Sherry', 
					'Matte', 'Kevin', 'Kevin', 'Vicente', 'Zoe', 'Kevin',
					'Matte', 'Zoe', 'Jay', 'Boris', 'Eadon', 'Sherry',
					'Franky', 'Sherry', 'Matte', 'Franky', 'Franky', 'Kevin',
					'Boris', 'Franky', 'Vicente', 'Luis', 'Eadon', 'Boris',
					'Kevin', 'Matte', 'Jay', 'James', 'Kevin', 'Sherry',
					'Sherry', 'Jack', 'Sherry', 'Jack']

# Seed Hero Ids		
heroes_list = Array.new
support_heroes.each do |person|
	heroes_list.push(person) if not heroes_list.include?(person)
	Hero.create( name: person) unless Hero.where( name: person ).first
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








	




