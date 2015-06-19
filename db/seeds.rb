require './app'

# Seed heroes

support_heroes = ['Sherry', 'Boris', 'Vicente', 'Matte', 'Jack', 'Sherry', 
					'Matte', 'Kevin', 'Kevin', 'Vicente', 'Zoe', 'Kevin',
					'Matte', 'Zoe', 'Jay', 'Boris', 'Eadon', 'Sherry',
					'Franky', 'Sherry', 'Matte', 'Franky', 'Franky', 'Kevin',
					'Boris', 'Franky', 'Vicente', 'Luis', 'Eadon', 'Boris',
					'Kevin', 'Matte', 'Jay', 'James', 'Kevin', 'Sherry',
					'Sherry', 'Jack', 'Sherry', 'Jack']
heroes_list = Array.new
support_heroes.each do |person|
	heroes_list.push(person) if not heroes_list.include?(person)
	Hero.create( name:  person ) if not heroes_list.include?(person)
	# heroes_list.push(person) if not heroes_list.include?(person)
	# new_hero = Hero.new( name: person )
	# Hero.create(new_hero)
end
puts heroes_list

	




