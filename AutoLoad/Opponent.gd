extends Node

# information about the wild creature
var opponent_name
var hasTamer 
var creature
var creature_reference 
var creature_name
var nickname
var health
var current_health
var experience
var current_experience
var damage
var defence
var level
var initial
var place_found
var tamer
var available_attacks
var description
var type

var tamed_creatures_list = []
var creature_position = 1

func get_creature ():
	return creature
	
func set_stats(new_creature):
	creature_reference = new_creature.creature_reference
	creature_name = new_creature.creature_name
	nickname = new_creature.nickname
	health = new_creature.health
	current_health = new_creature.current_health
	experience = new_creature.experience
	current_experience = new_creature.current_experience
	damage = new_creature.damage
	defence = new_creature.defence
	level = new_creature.level
	initial = new_creature.initial
	place_found = new_creature.place_found
	tamer = new_creature.tamer
	type = creature.type
	available_attacks = new_creature.available_attacks
	description = new_creature.description
	
func choose_random_attack ():
	return available_attacks[randi() % available_attacks.size()]
	
#func choose_random(rand_list):
#	return rand_list[randi() % rand_list.size()]

func get_stats():
	var stats = {
		"creature_reference": creature_reference,
		"name": creature_name,
		"nickname":nickname,
		"health" :health,
		"current_health":current_health,
		"experience" :experience,
		"current_experience" :current_experience,
		"damage" :damage,
		"defence" :defence,
		"level" :level,
		"initial" :initial,
		"place_found" :place_found,
		"description": description,
		"type": type,
		"tamer" :tamer,
		"available_attacks" :available_attacks
	}
	
	print (stats)
	return stats
	
