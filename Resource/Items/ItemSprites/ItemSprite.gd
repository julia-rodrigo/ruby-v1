tool
extends TextureRect
class_name Draggable
export (Resource) var ITEM setget _setItem


#https://www.youtube.com/watch?v=nR0nCFJ8-qM
# called everytime the item is updated

var id: int
var label: String

var dropped_on_target: bool = false

func _ready() -> void:
	add_to_group("DRAGGABLE")

func get_drag_data(_position: Vector2):
	print("DRAGGABLE data ")
	if not dropped_on_target:
		set_drag_preview($AppleSpriteControlNode)
		return self
	
func addAmount (x: int):
	ITEM.addAmount(x)

func _setItem (newItem : Item):
	print("setting new item")
	ITEM = newItem
	self.texture = newItem.getBigTexture()

