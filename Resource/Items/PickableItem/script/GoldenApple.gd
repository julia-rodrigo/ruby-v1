extends Area


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_GoldenApple_body_entered(body):
	if (body == Global.player):
		Player.inventory.add_item("Golden Apple", 1)
		queue_free()
		print("golden apple: you touched me!")
	else:
		print("golden apple: you didnt touched me...")
		
