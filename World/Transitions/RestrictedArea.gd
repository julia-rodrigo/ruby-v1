extends Area

# area to restrict the player if a certain quest is not done

export (int) var quest_level_completed = 0 # player can progress is this level is the same as the current quest id

export (String) var who_says = "Fat and Poofy"
export (Array, String) var you_cant_go = [
	"oh ya can't enter", "yeah"
]

onready var dialogue_box = preload("res://Resource/NPC/NPCInteractions/NPCDialogues/DialogueBox.tscn").instance()
#onready var character_name_label = dialogue_box.get_node("outer/Panel/inner/list/name")
onready var dialogue_box_message = dialogue_box.get_node("outer/Panel/inner/list/message")

func _on_RestrictedArea_body_entered(body):
	if (body == Global.player):
		print("hi player :)))")
		if (Quest.CURRENT_QUEST_ID > quest_level_completed):
			print(" you are free to go")
			Global.auto_move_direction = body.direction
			Global.auto_move_run_sprite = body.automove_run_sprite
			body.auto_move()
		else:
			load_dialogue()
			print ("EHEHEHHEHHHEHH")
			Global.auto_move_direction = -body.direction
			Global.auto_move_run_sprite = body.OppositeDirections[body.automove_run_sprite]
			body.auto_move()

func load_dialogue():
	dialogue_box.dialogue = you_cant_go
	dialogue_box.name_of_character = who_says
	add_child(dialogue_box)
	
	dialogue_box = preload("res://Resource/NPC/NPCInteractions/NPCDialogues/DialogueBox.tscn").instance()

