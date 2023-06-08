extends Node

class_name RandomFinder

export (Array, Resource) var creature_list: Array = []

func find_random_creature(creature_array: Array = creature_list):
	var chosen_value = null
#	print("random finder: ", creature_array)
	

	if creature_array.size() > 0:
		var overall_chance: int = 0
		for creature in creature_array:
			if creature.can_be_found:
				overall_chance += creature.ENCOUNTER_CHANCE
#		print("overall_chance: " , overall_chance)

		var random_number = randi() % overall_chance
		var offset: int = 0

		for creature in creature_array:
			if creature.can_be_found:
				if random_number < (creature.ENCOUNTER_CHANCE + offset):
					chosen_value = creature
					break
				else:
					offset += creature.ENCOUNTER_CHANCE
		
#	print("chosen_value Final: " , chosen_value)
	
	#genereates attacts
	chosen_value.generate_creature_attacks()
	chosen_value.creature_info()
	
	return {
		"resource": chosen_value,
		"name": chosen_value.name,
		"health": chosen_value.health,		
		"damage": chosen_value.damage,
		"level": chosen_value.level
	}

