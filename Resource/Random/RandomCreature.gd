extends Resource

class_name RandomCreature

#extends Spatial
#onready var sprite = Player.creatures[0]
#var sprite_instance = Player.creatures[0].sprite.instance()
#
#func _ready():
#	print("here in help menu: ", sprite_instance)
#	add_child(sprite_instance)
#	get_node("EnemyBattleSprite/KinematicBody/AnimationPlayer").play("%s_Idel" % [sprite.name])
#	get_node("EnemyBattleSprite/KinematicBody").get_node("%sIdel" % [sprite.name]).show()
#	pass
export(String) var name = "Creature"

export var sprite = preload("res://creatures/Tihi.tscn")

export (int) var health: int = 1
export (int) var current_health: int = 1

export (int) var experience: int = 1
export (int) var current_experience: int = 1

export (int) var damage: int = 1
export (int) var defence: int = 1

export (int) var level: int = 1


export (String, MULTILINE) var description

export (int) var ENCOUNTER_CHANCE: int = 1
export (bool) var can_be_found: bool = true

export (String) var type = "unknown"

var nickname = name
var place_found = "Unknown"
var can_release
var initial = level
var tamer = "Rubyyy"
var available_attacks = {}
export (Resource) var item

export (Array, Resource) var held_item = {
	"x": name,
}

func get_type_of_reward():
	return "Creature"
	
#name_area_label.text = Player.current_creature.name
#		level_area_label.text = Player.current_creature.level
#		tamer_area_label.text = Player.current_creature.tamer
#		found_area_label.text = Player.current_creature.area
#		initial_area_label.text = Player.current_creature.initial
		
# https://github.com/godotengine/godot/issues/74975

#export (Array, String) var current_attack_set = {
#	"x": damage,
#}
#
#export (Array, String) var damage_set = {
#	"x": damage,
#}


var available_attacks_set = [
		{ "name":  "Claw", "damage": 2 , "description": "A basic attack most monsters know!", "chance": 20 },
		{ "name":  "CapHat", "damage": 5, "description": "Thats a Feet Special!", "chance": 5  },
		{ "name":  "Bella", "damage": 4, "description": "Thats a Tihi Special!", "chance": 5  },
		{ "name":  "Sniff", "damage": 2, "description": "Hey!", "chance": 20  },
		{ "name":  "Paw", "damage": 1, "description": "soft feet", "chance": 20  },
		{ "name":  "Hide", "damage": 3, "description": "Searching.... !", "chance": 10  },
		{ "name":  "Aero", "damage": 3, "description": "Thats a Hasven Special!", "chance": 5  },
		{ "name":  "Top Star :D", "damage": 100000, "description": "This is Tendo Maya!", "chance": 1  }
	]

func generate_creature_attacks ():
#	print("AVAIABLE AT THE MOMENT", available_attacks_set)
	available_attacks = randomAttackGenerator(available_attacks_set)
	return available_attacks
	
func get_creature_attacks ():
	return available_attacks

func randomAttackGenerator (list):
#	print("\n\nrandomAttackGenerator")
	
	var creature_attacks = []
	var indexList = range(list.size())

	for _i in range(2):
		var overall_chance: int = 0
		for attack in list:
			overall_chance += attack.chance
#			print("chance: ", attack.chance)

		var random_number = randi() % overall_chance
#		print("random_number: ", random_number)
		
		var offset: int = 0

		var chosen_attack = null
#
		for attack in list:
			if random_number < (attack.chance + offset):
				chosen_attack = attack
				break
			else:
				offset += attack.chance	
#		print ("\nchosen_attack: ", chosen_attack)
		creature_attacks.append(chosen_attack)

		var x = list.find(chosen_attack)
		list.remove(x)
		indexList.remove(x)
#		print ("remaining attacks: ", list)
		
#	print ("\nfinal_creature_attacks: ", creature_attacks)
	
	available_attacks_set = [
		{ "name":  "Claw", "damage": 2 , "description": "A basic attack most monsters know!", "chance": 20 },
		{ "name":  "CapHat", "damage": 5, "description": "Thats a Feet Special!", "chance": 5  },
		{ "name":  "Bella", "damage": 4, "description": "Thats a Tihi Special!", "chance": 5  },
		{ "name":  "Sniff", "damage": 2, "description": "Hey!", "chance": 20  },
		{ "name":  "Paw", "damage": 1, "description": "soft feet", "chance": 20  },
		{ "name":  "Hide", "damage": 3, "description": "Searching.... !", "chance": 10  },
		{ "name":  "Aero", "damage": 3, "description": "Thats a Hasven Special!", "chance": 5  },
		{ "name":  "Top Star :D", "damage": 100000, "description": "This is Tendo Maya!", "chance": 1  }
	]
	
	return creature_attacks
	
func shuffleList(list):
	var shuffledList = []
	var indexList = range(list.size())
	
	for _i in range(list.size()):
		randomize()
		var x = randi()%indexList.size()
		print(list[x])
		
		shuffledList.append(list[x])
		indexList.remove(x)
		list.remove(x)
	return shuffledList
	
func creature_info ():
	return {
		"name": name,
		"nickname": nickname,		
		"health": health,	
		"current_health": current_health,	
		"experience": experience,	
		"current_experience": current_experience,	
		"damage": damage,
		"level": level,
		"initial": level,
		"place_found": place_found,
		"tamer": tamer,	
		"available_attacks": get_creature_attacks ()
	}
	
	
