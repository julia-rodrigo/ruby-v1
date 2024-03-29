extends MultiMeshInstance

# before the player exits to a battle scene and this script activated in the grass section

var encounterChance = 40 
var rand_value = null;

func get_random_number():
	return randi()%100
	
func randomEnemy(body) :
	

	var randomFinder = RandomFinder.new()
	var creature = randomFinder.find_random_creature(Global.creature_encounter_list).resource
	
	Global.encountered_creature = {
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

	Global.from_Grass = $"../".get_parent().name
	Global.PlayerPosition = body.global_transform.origin
	visible = false
	Global.battle_level_path = $"../".get_parent().filename
	Player.at_battle = true
	
	Global.disconnect_player()
	var _not_in_use = get_tree().change_scene("res://World/WildBattleEncounters/" + $"../".get_parent().name + "Encounter.tscn")
	
	
	
func _on_Area_body_entered(body):
	if Global.back_from_battle == true:
		Global.back_from_battle = null
#		print("reset grass")
	else:
		rand_value = true if (get_random_number() % 100 < encounterChance) else false
		print("rand_value: ", rand_value)
		if(rand_value) :
			if(body.name == "Ruby"):
				body.moving = false
			randomEnemy(body)

func _on_Area_body_exited(_body):
	Global.back_from_battle = null
	pass # Replace with function body.


func _on_AreaIn_body_entered(body):
	if Global.back_from_battle_Inner == true:
		Global.back_from_battle_Inner = null
#		print("reset grass")
	else:
		rand_value = true if (get_random_number() % 100 < encounterChance) else false
		print("rand_value: ", rand_value)
		if(rand_value) :
			if(body.name == "Ruby"):
				body.moving = false
			randomEnemy(body)


func _on_AreaIn_body_exited(_body):
	Global.back_from_battle_Inner = null
	pass # Replace with function body.
