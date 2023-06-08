extends Spatial

# this will be just a start dialogue and an end dialogue for completing the game

onready var dialogue_box = preload("res://Resource/NPC/NPCInteractions/NPCDialogues/DialogueBox.tscn").instance()

export (String) var who_says = "Poofy"
export (Array, String) var message = [
	"The one and only poofy cult leader :>"
]

export (int) var appear_on_quest = 0

func _ready():
	
	if Quest.CURRENT_QUEST_ID == appear_on_quest:
		dialogue_box.name_of_character = who_says
		dialogue_box.dialogue = message
		add_child(dialogue_box)
		dialogue_box = preload("res://Resource/NPC/NPCInteractions/NPCDialogues/DialogueBox.tscn").instance()

