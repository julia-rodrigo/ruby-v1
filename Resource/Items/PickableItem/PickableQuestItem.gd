extends Area

export (Resource) var item 
export (int) var quest_id = 0

func _process(_delta):
	
	if Player.adventure_log.get_adventures().size() > 0:
		if Player.adventure_log.get_adventure(quest_id).completed:
			print("%s is gone because the adventure for it is already finished" % item.name)
			queue_free()
		elif Player.inventory.get_item_by_name(item.name):
			print("you already have the %s. so we took it off the map" % item.name)
			queue_free()
		set_process(false)
		
func _on_PickableQuestItem_body_entered(body):
	if (body == Global.player):
		Player.inventory.add_item(item.name, 1)
		queue_free()
		print("Obtained %s!" % item.name)
		
