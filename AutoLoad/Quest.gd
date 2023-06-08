extends Node

# check the current quest id and the name of the current test
var CURRENT_QUEST_ID = 0
var current_quest 

# check the current player text box and if the battle with an oposing tamer win
var dialogue_box_finished = false
var battle_player_wins = false

# redundant function i dunno why I needed this
func get_current_quest():
	return current_quest

# the name if the challenger opponent and information during the battle
var challenger_name
var challenger_tamer_team
var challenger_intro_message
var challenger_post_message
var challenger_team_position = 0
var challenger_current_creature
var challenger_lose = false

# check if challenger has next creature
func challenger_next_creature():
	challenger_team_position += 1
	print("CHALLENGER TEAM SIZE: ", challenger_tamer_team.size())
	if challenger_team_position < challenger_tamer_team.size():
		
		challenger_current_creature = challenger_tamer_team [challenger_team_position]
		print("challenger_current_creature: ", challenger_current_creature)
		
		return challenger_current_creature
	else:
		challenger_lose = true
		print("%s has no more creatures to fight with" % challenger_name)
		return null

# opponent chooses random attacks
func choose_random_attack (creature):
	return creature.available_attacks[randi() % creature.available_attacks.size()]
	
# level up oppontn's team by an amount
func buff_up_tamer_team (team, amount):
	var oof_team = []
	for creature in team:
		creature = increase_level_of_creature(creature, amount)
		oof_team.append(creature)
		
#	print("\ncreature grnama: ", oof_team)
	return oof_team

func increase_level_of_creature(creature, amount):
	creature = set_creature_stats (creature)
	
	for _i in range(amount):
		creature = level_up(creature)
		
#	check_creature_stats(creature)
	
	return creature

func level_up (creature):
	creature.level += 1
	creature.health += randi() % 15 + 10
	creature.defence += randi() % 4 + 2
	creature.damage += randi() % 2 + 1
	creature.current_health = creature.health

	return creature
	

func set_creature_stats (creature):
	var stats = {
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
		tamer = challenger_name,
		available_attacks = creature.generate_creature_attacks()
	}
	
	return stats

func check_creature_stats(creature):
	
	var creature_stats_key = creature.keys()
	var creature_stats_value = creature.values()
	
	var full_info = { creature_reference = creature }
	
	for i in creature.size():
		full_info.merge({ 
			creature_stats_key[i] : creature_stats_value[i]
		})
		
	print("full info, ", full_info)
	return full_info



