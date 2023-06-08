extends MultiMeshInstance

var inGrass = false

var booleanGenerator = [true, false]
var encounterChance = 40 # percentage encounter
var repeatEncounterTime = 0.8
var rand = RandomNumberGenerator.new()
var rand_value = null;
#var timer = get_tree().create_timer(3, false)

#var EncounterBattle = preload("res://World/BattleUI/Level1/Level1Encounter.tscn")
var start = true

func _on_Area_body_entered(body):
	if Global.back_from_battle == true:
		Global.back_from_battle = null
		print("reset grass")
	else:
		rand_value = true if (get_random_number() % 100 < encounterChance) else false
		print("rand_value: ", rand_value)
		if(rand_value) :
			if(body.name == "Ruby"):
				body.moving = false
			randomEnemy(body)
				
#				body.moving = false
			
#			get_tree().change_scene("res://World/Levels/World.tscn")
			

func get_random_number():
	return randi()%100
	
func randomEnemy(body) :
	Global.from_Grass = get_parent().name
	Global.PlayerPosition = body.global_transform.origin
	visible = false
	Global.battle_level_path = get_parent().filename
	var _not_in_use = get_tree().change_scene("res://World/WildBattleEncounters/" + get_parent().name + "Encounter.tscn")
	
func _on_Area_body_exited(_body):
	Global.back_from_battle = null
	pass # Replace with function body.


func _on_AreaIn_body_entered(body):
	if Global.back_from_battle_Inner == true:
		Global.back_from_battle_Inner = null
		print("reset grass")
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
