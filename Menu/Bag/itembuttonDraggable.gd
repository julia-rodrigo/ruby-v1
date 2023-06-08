extends Button
var item
var position

# set the dragable group function and name
func _ready() -> void:
	add_to_group ("DRAGGABLE")
	
func get_drag_data(_position: Vector2):
	print("[DRAGGABLE]")
	return self
