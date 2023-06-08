extends Node

# player name and if the player is allowed to move
var player_name = "Hi I am Ruby"
var move = true

# if the player is at the battle or if it's player's turn
var at_battle = false
var turn = true

# check the player's current creature
var creature_name
var level = 1
var current_health = 35
var max_health = 35
var defence = 3

var available_attacks = []

var current_EXP = 10
var max_EXP = 30

# position in the tamer_'s team array
var creature_position = 0

# get information on the creature caught
var creature_caught

# player current dizziness and the dizziness item
var current_dizziness = 5
var max_dizziness = 20
var recover_from_dizziness
var recovery_dizziness_item

var damage = 20
var apples = 0


# test variables
var creatures = [ preload("res://Resource/Random/Creatures/Tihi_fox.tres"), preload("res://Resource/Random/Creatures/Feet_cat.tres") ]
var current_creature

# load the save files from the directories and intialise a new file
var inventory_resource = load ("res://Resource/Inventory/Inventory.gd")
var inventory = inventory_resource.new()

var creaventory_resource = load ("res://Resource/Inventory/Creaventory.gd")
var creaventory = creaventory_resource.new()

var adventure_log_resource = load ("res://Resource/Inventory/AdventureLog.gd")
var adventure_log = adventure_log_resource.new()

# if the player partner used an item during battle
var player_partner_used_item 
var item_used

# get the current diziness score of the player once item has been used
func dizziness_recovery ():
	current_dizziness = min(max_dizziness, current_dizziness + recovery_dizziness_item.item_reference.get_dizziness_recovery())

# https://godotengine.org/qa/2539/how-would-i-go-about-picking-a-random-number

# level up the creature
func level_up ():
	level += 1
	max_health += randi() % 15 + 10
	defence += randi() % 4 + 2
	damage += randi() % 2 + 1
	
	current_EXP = 0
	max_EXP += 60
	max_dizziness += 2
	
	return {
		level: level,
		max_health: max_health,
		defence: defence,
		damage: damage,
	}
	

# ----------player bag ----------------

# test function
func get_inventory_items () :
#	print("\nITEMS IN PLAYER BAG: (Player.gd) --> ", inventory.get_items())
	print("\nGET FIRST ITEM IN PLAYER BAG: (Player.gd) --> ", inventory.get_item(0))
	

# -------------------------

#var creatures = []
#var current_creature

var lose = false # go to last saved point

# choose a random attack from the wild creature's side
func choose_random_attack ():
	return available_attacks[randi() % available_attacks.size()]
	
	
var save_stats_file = {
	"level": 1,
	"current_health": 35,
	"max_health": 35,
	"current_EXP": 10,
	"max_EXP": 30,
	"current_dizziness": 5,
	"max_dizziness": 20,
	"damage": 20,
	"defence": 20,
	"apples": 0,
	"creatures": [],
	"place": "not known",
	"where": "dunno",
}

func save_current_stats():
	save_stats_file = {
		"level": level,
		"current_health": current_health,
		"max_health": max_health,
		"current_EXP": current_EXP,
		"max_EXP": max_EXP,
		"current_dizziness": current_dizziness,
		"max_dizziness": max_dizziness,
		"damage": damage,
		"defence": 20,
		
		"apples": apples,
		"creatures": creatures,
		"place": Global.LevelPathway_HelpSave,
		"where": Global.PlayerPosition_HelpSave,
	}
	print ("saved: ", save_stats_file)
	return save_stats_file

onready var randomFinder = RandomFinder.new()


func _ready():
	print("i am herer: ", Global.creature_encounter_list)
	save_current_stats()
	pass

func _input(event):
#	if ev is InputEventKey and ev.scancode == KEY_M and not ev.echo:
		if event is InputEventKey:
			if event.is_pressed() == false:
				match event.scancode :
					KEY_P:
						player_dev_team()
						

# redundant fucntions for testing
func player_dev_team ():
	creatures = [ 
		randomFinder.find_random_creature(Global.creature_encounter_list).resource,
		randomFinder.find_random_creature(Global.creature_encounter_list).resource
	]
	for i in range(creatures.size()):
		creatures[i].tamer = player_name
		creatures[i].place_found = Global.current_level_name
		creatures[i].initial = creatures[i].level
		creatures[i].initial = creatures[i].level
		creatures[i].available_attacks = creatures[i].generate_creature_attacks()
		
	current_creature = creaventory[creature_position]
#	print(creatures[0].available_attacks)

func get_creature_stats(check_creature):
	var stats = {
		"creature_name": check_creature.name,
		"nickname": check_creature.nickname,		
		"health": check_creature.health,	
		"current_health": check_creature.current_health,	
		"experience": check_creature.experience,	
		"current_experience": check_creature.current_experience,	
		"damage": check_creature.damage,
		"defence": check_creature.defence,
		"level": check_creature.level,
		"initial": check_creature.level,
		"type": check_creature.type,
		"place_found": check_creature.place_found,
		"tamer": check_creature.tamer,	
		"available_attacks": check_creature.available_attacks
	}
	
	print(stats)
	return stats
