extends Spatial

var interaction = preload("res://Interactions/DialogueTest.tscn")
signal dialogue_closed

func startInteraction():
	destory()
	respawn()
	yield(self, "dialogue_closed")

func destory():
	if self.get_child_count() > 0:
		self.get_child(0).queue_free()

func respawn():
	var interaction_instance = interaction.instance()
	self.add_child(interaction_instance)
