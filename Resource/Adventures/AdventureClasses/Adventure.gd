extends Resource

class_name Adventure

export (String) var name
export (String, MULTILINE) var description
export (Array, Resource) var reward = [

]

export (Array, String) var post_quest_message = [
]

export (String) var post_talk_to_me = ":)"

export (String, MULTILINE) var next_quest_hint = "What is the next quest?"

export (int) var quest_id = 0
var quest_on = true
var completed = false
var quest_info

func _ready():
	quest_info = get_quest_info()
	
func completed_quest ():
	completed = true
	quest_on = false
	
func collect_reward():
	for received_reward in reward:
		if received_reward.get_type_of_reward() == "Item":
			Player.inventory.add_item(received_reward.name, 1)
		elif received_reward.get_type_of_reward() == "Creature":
			Player.creaventory.add_creature(received_reward.name)
	completed_quest()
	print("RECEIVED THE REWARD!!!")
	 
func get_quest_info ():
	return {
		"name": name,
		"description": description,
		"quest_id": quest_id,
		"reward": reward,
		"quest_on": quest_on,
		"completed": completed,
		"next_quest_hint": next_quest_hint,
	}
