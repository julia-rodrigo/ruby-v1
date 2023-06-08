extends Area


func _on_Apple_body_entered(body):
	if (body == Global.player):
		Player.inventory.add_item("Apple", 1)
		queue_free()
		print("apple: you touched me!")
	else:
		print("apple: you didnt touched me...")
		
