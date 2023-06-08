extends Area

var entered = false;

func _on_Area_body_entered(body: PhysicsBody):
	entered = true
	pass # Replace with function body.




func _on_Area_body_exited(body):
	entered = false
	pass # Replace with function body.

func _process(delta):
	if entered == true:
		if Input.is_action_just_pressed("ui_accept"):
#			Loading.load_scene(self, "res://Battle.tscn")
			get_tree().change_scene("res://Battle.tscn")
