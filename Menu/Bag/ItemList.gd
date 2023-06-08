extends VBoxContainer

# update inventory when changed

onready var newItem = preload("res://Menu/Bag/NewItem.tscn").instance()
onready var item_name_button = newItem.get_node("item/name")
onready var item_info_label = newItem.get_node("item/details/info")
var position = 0

func _ready():
	var _not_in_use = Global.connect("player_initialised", self, "_on_player_initialised")
	_on_player_inventory_changed (Player.inventory)
	
func _on_player_initialised (_player):
	var _not_in_use = Player.inventory.connect("inventory_changed", self, "_on_player_inventory_changed")
	position = 0
	
func _on_player_inventory_changed (inventory):
	for n in get_children():
		n.queue_free()
	
	for item in inventory.get_items ():
		setNewItem(item, item.item_reference.name, item.amount)
		position += 1
	
#	get_tree().quit()
	position = 0

func setNewItem (item, item_name, item_info):
	newItem.button_position = position
	item_name_button.text = item_name
	item_info_label.text = "%s" % [item_info]
	item_name_button.item = item
	item_name_button.position = position
	
	
	add_child(newItem)
	
	newItem = preload("res://Menu/Bag/NewItem.tscn").instance()
	item_name_button = newItem.get_node("item/name")
	item_info_label = newItem.get_node("item/details/info")

