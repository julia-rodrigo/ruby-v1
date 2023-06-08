extends Area

# when the player enters a new level
func _on_Entrance_body_entered(body):
	if body.name == "Ruby" :
		Global.from_level = get_node("../").get_parent().name
		Global.idelName = body.viewingSprite(body.idelName, body.RunToIdel[body.idelName])	
		Global.battle_level_path = null
		
		
		Global.auto_move_direction = body.direction
		Global.auto_move_run_sprite = body.automove_run_sprite
			
		Global.disconnect_player()
#		Loading.load_scene(self, "res://World/Levels/" + self.name + ".tscn")
		var _not_in_use = get_tree().change_scene("res://World/Levels/" + self.name + ".tscn")
 
