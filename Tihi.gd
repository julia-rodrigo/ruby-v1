extends Spatial
export(Resource) var data 
# https://docs.godotengine.org/en/stable/tutorials/scripting/resources.html

# Called when the node enters the scene tree for the first time.
func _ready():
	
	get_node("KinematicBody/AnimationPlayer").play("Tihi_Idel");
	
	
	pass # Replace with function body.
