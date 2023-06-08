extends Node

# this is to do with the battle sections
var selected
var position = 0
var player_renaming
var new_nickname
var info_text_selected
var update_creature 

var bag_selected_creature
var bag_creature_position

var leader_position = 0 # creature at the start of the battle
var creature_released 

var select_during_battle_on
var battle_creature_selected_position


# this is to select the healthy creature from the team 
# or just pick the first creature if everyone is unhealthy

func select_health_creature_position():
	var pos = 0
	for creature in Player.creaventory.get_creatures():
		if(creature.current_health > 0):
			return pos
		pos += 1
	return 0
	

# check if there is a healthy creature in the player's team
# to continue battle or to loose the battle

func can_team_continue():
	var unable_to_battle = 0
	var tamer_team = Player.creaventory.get_creatures()
	var size = tamer_team.size()
	for creature in tamer_team:
		if(creature.current_health == 0):
			unable_to_battle += 1
		print("current health: ", creature.current_health)
	if unable_to_battle == size:
		return false
	else:
		return true

#var updated_tamer_list = []

func ready_set_wild_creature (creature): # get base creature resource
	return {
		creature_reference = creature,
		creature_name = creature.name,
		nickname = creature.name,
		health = creature.health,
		current_health = creature.current_health,
		experience = creature.experience,
		current_experience = creature.current_experience,
		damage = creature.damage,
		defence = creature.defence,
		level = creature.level,
		type = creature.type,
		description = creature.description,
		initial = creature.level,
		place_found = Global.current_level_name,
		tamer = null,
		available_attacks = creature.generate_creature_attacks()
	}
