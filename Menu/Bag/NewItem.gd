extends MarginContainer

onready var item_name_button = $item/name
onready var item_info_label = $item/details/info
var button_position = 0
var item

# get the item when pressed
func _on_name_pressed():
	print("button pressed: ", (self.name))
	item = Player.inventory.get_item(button_position)
	print(item.item_reference.name)
	get_info()
	
# save the into the info variable	
func get_info ():
	print("button pressed INFO: ", item.item_reference.description)
	Global.bag_item_selected_info = item.item_reference.description
	return item
