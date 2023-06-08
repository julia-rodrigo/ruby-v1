extends Spatial

# https://stackoverflow.com/questions/72459978/how-to-set-and-get-position-of-an-object-in-godot-3d
# https://youtube.com/shorts/jmI1G_VTjj4?feature=share

#and ev.is_pressed == true :
#
#or
# (0.121116, -0.111504, -0.804419
#and ev.is_pressed == false :
#
#in if statement
#the former is at press state
#the latter is at released state

# https://godotengine.org/qa/30582/how-to-detect-which-key-is-pressed

#onready var quest_items = $Items/Quest

# this is getting ready the level and taking in all the creatures_array in export variable
export(Array, Resource) var creatures_array: Array = []

# when the player enters a new level

func _ready():
	Player.move = true
	Global.creature_encounter_list = creatures_array
	print("creatures_array ", creatures_array)
	
	Global.current_world_filepath = "res://World/Levels/" + self.name + ".tscn"
	Global.current_level_name = self.name
	Global.current_scene_name = self.name
	print("Global.current_world_filepath: ", Global.current_world_filepath)
	
	if (Global.PlayerPosition_SignSave != null and Player.lose):
		Player.lose = false
		Global.from_Grass = false
		Global.PlayerPosition = null
		
		Player.current_health = Global.SignSave_PlayerHealth
		
		print("here in levels.gd 1")
		get_node("Ruby").global_transform.origin = (get_node("Player_SaveSpawn").translation)
	elif Global.from_Grass:
		print("here in levels.gd 2")
		
		Global.from_Grass = null
		get_node("Ruby").global_transform.origin = Global.PlayerPosition
		get_node("InterpolatedCamera").global_transform.origin = Global.PlayerPosition
		
	elif Global.from_level != null:
		print("here in levels.gd 3")
		
		if Player.lose:
			Player.current_health = Global.HelpSave_PlayerHealth
			Player.lose = false
		
		get_node("Ruby").global_transform.origin = (get_node("ConnectedWorlds/" + Global.from_level + "Pos").translation)
		get_node("InterpolatedCamera").global_transform.origin = (get_node("ConnectedWorlds/" + Global.from_level + "Pos").translation)
		
		get_node("Ruby").auto_move()
#	check_quest_item()
#
#func check_quest_item():
#	quest_items

