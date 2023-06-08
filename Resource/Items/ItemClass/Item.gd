tool # to export resources
extends Resource

class_name Item

export (String) var name
export (int) var amount = 1
export (Texture) var little_texture
export (Texture) var big_texture
export (PackedScene) var sprite

export (String, MULTILINE) var description
export (String, MULTILINE) var hover_text

export (int) var chance

export (Array, Resource) var held_by = {
	"x": name,
}

export var stackable : bool = false
export var max_stack_size : int = 1

enum ItemType { Generic, Food, Quest, Equipment }
export (ItemType) var type

export (bool) var food = true

# if 3d item
export var mesh : Mesh


func get_type_of_reward():
	return "Item"


func addAmount (x: int):
	amount += x

func getAmount ():
	return amount

func getLittleTexture () -> Texture:
	return little_texture

func getBigTexture () -> Texture:
	return big_texture


func getSprite () -> PackedScene:
	return sprite




func _ready():
	pass
