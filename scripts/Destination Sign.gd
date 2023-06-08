extends Spatial


#func _process(delta):
#	if entered == true:
#		if Input.is_action_just_pressed("ui_accept"):
#			get_tree().change_scene("res://scripts/Battle.gd")
var text = "Welcome! I am sign. I don't do much lmao but if you seee me, I'll always save your progress! so please stop by us!"

func _ready():
	get_node("AnimationPlayer").play("Direction_Sign");
	get_node("Panel/MarginContainer/Label").text = text	
	get_node("Panel").rect_size.x = get_node("Panel/MarginContainer/Label").rect_size.x + text.length();
	get_node("Panel").rect_size.y = get_node("Panel/MarginContainer/Label").rect_size.y + text.length()*0.4;
	
	pass # Replace with function body.

func _on_SaveTrigger_body_entered(body):
#	print('hello')
	if body.name == 'Ruby':
		get_node("Panel").show()
		Global.PlayerPosition_SignSave = $"../Player_SaveSpawn".translation
		Global.LevelPathway_SignSave = "res://World/Levels/" + get_parent().name + ".tscn"
		Global.SignSave_PlayerHealth = Player.current_health
		Global.LevelName_SignSave = get_parent().name
		
		print(Global.LevelPathway_SignSave)
		print(Global.PlayerPosition_SignSave)
#		get_node("Panel").rect_position.y = get_node("Panel/MarginContainer/Label").rect_size.y - 60;

func _on_SaveTrigger_body_exited(body):
	if body.name == 'Ruby':
		get_node("Panel").hide()

