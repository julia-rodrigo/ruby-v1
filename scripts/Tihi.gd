extends Spatial
export (Resource) var data 
# https://docs.godotengine.org/en/stable/tutorials/scripting/resources.html

# Called when the node enters the scene tree for the first time.
func _ready():
#	get_node("KinematicBody/AnimationPlayer").play("Tihi_Idel");
	
	pass # Replace with function body.

func ready_creature_sprite(name):
	get_node("KinematicBody/AnimationPlayer").play("%s_Idel" % [name])
	get_node("KinematicBody").get_node("%sIdel" % [name]).show()
	
