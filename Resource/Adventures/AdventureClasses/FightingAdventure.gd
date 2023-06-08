extends Adventure
class_name FightingAdventure

export (int) var amount_to_fight
export (Array, Resource) var creatures_to_fight

var amount_faught = 0

func check_creature_faught (faught_creature):
	for creature in creatures_to_fight:
		if faught_creature.name == creature.name:
			amount_faught += 1

func get_amount_faught ():
	return amount_faught

func get_amount_to_fight ():
	return amount_to_fight

func kind_of_adventure ():
	return "Fighting"
	
func get_creatures_to_fight():
	var creatures_need = []
	for creature in creatures_to_fight:
		creatures_need.append(creature.name)

	print("creatures_need in fighting adventrue.gd: ", creatures_need)
	return creatures_need
