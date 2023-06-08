extends Panel

# the area of the creature when an item is being dragged

var item_sprite = load("res://Resource/Items/ItemSprites/ItemSprite.tscn").instance()
var panel_position

func _ready():
	pass
		
func can_drop_data(_position: Vector2, data) -> bool:
	var can_drop: bool = data is Node and data.is_in_group("DRAGGABLE")
	return can_drop
	
func drop_data(position: Vector2, data) -> void:
#	print("[TARGET CONTAINER diff]", position)
	print(data.item)
	if(data.item.item_reference.food == true):
		print("its a food!!!!!")
		
		item_sprite.rect_position = position
		item_sprite.texture = data.item.item_reference.big_texture
		
		Global.bag_item_sprite = item_sprite
		Global.bag_item_panel_position = panel_position
		Global.bag_item_position_in_panel = position
		
		print("position of panel: ", panel_position)
		
		if(Player.at_battle):
			Player.item_used = data.item
			Player.player_partner_used_item = true
		
		food_stats_given (data.item.item_reference.food_eaten(), Player.creaventory.get_creature(panel_position))
		Player.recover_from_dizziness = true
		Player.recovery_dizziness_item = data.item
		
		Player.inventory.subtract_item(data.position, 1)
		item_sprite = load("res://Resource/Items/ItemSprites/ItemSprite.tscn").instance()
		
	else:
		print("%s is not a food!!!" % [data.item.item_reference.name])

func food_stats_given (stats_obtained, creature):
	print("STATS: ", stats_obtained)
	print("for: ",creature.name)
	var stats_names = []
	
	for stats in stats_obtained:
		stats_names.append(stats)

	for i in range(stats_obtained.size()):
		if stats_names[i] == "current_health":
			creature.current_health = min(creature.health, creature.current_health  + stats_obtained.current_health)
		else:
			creature[stats_names[i]] = creature[stats_names[i]] + stats_obtained[stats_names[i]]
		
#		print("%s: %s" % [stats_names[i], creature[stats_names[i]]])
	Player.creaventory.player_creature_info_changed(panel_position, creature)
		
