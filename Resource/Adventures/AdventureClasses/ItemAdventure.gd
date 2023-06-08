tool
extends Adventure
class_name ItemAdventure


export (int) var amount_to_collect = 1
#export (Array, Resource) var creatures_to_fight
export (Resource) var item_needed 

var current_amount = 0

func check_item_needed (item):
	if item.name == item_needed.name:
		current_amount += 1

func get_current_amount ():
	current_amount = Player.inventory.get_item_amount(item_needed.name)
	return current_amount

func get_amount_to_collect ():
	return amount_to_collect
	
func kind_of_adventure ():
	return "Item"

func get_additional_quest_info ():
	var additional_info = {
		"name": name,
		"amount_to_collect": amount_to_collect,
		"item_needed": item_needed,
		"current_amount": current_amount,
		"completed": completed
	}

	additional_info.merge(get_quest_info())
	return additional_info
