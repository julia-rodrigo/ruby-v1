extends Panel

# update when player selects anything in the bag
func _process(_delta):
	if(Global.bag_item_selected_info != null):
		get_node("info").text = Global.bag_item_selected_info
		Global.bag_item_selected_info = null
	pass # Replace with function body.
