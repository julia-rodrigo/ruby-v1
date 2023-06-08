extends Node

onready var animation_player = $CreatureSprites/AnimationPlayer
onready var creature_sprites = $CreatureSprites

onready var conversation_area = $ConversationArea

export (String) var character_name = "I have no name...."

export (Array, String) var message = [
	"I am a creature", "oh this is a message", "um yeah"
]

export (String) var talk_to_me = "grgrgr"

export (bool) var battle_mode = false

export (Resource) var creature
export (Resource) var quest
export (bool) var gone_after_quest = false

var battle_creature 

func _ready():
	print("NPC creature: ", creature.name)
	ready_creature_sprite(creature.name)
	battle_creature = Creature.ready_set_wild_creature(creature)
	
	conversation_area.character_name = character_name
	conversation_area.message = message
	conversation_area.talk_panel.get_node("inner/separate/press").text = talk_to_me

	conversation_area.talk_to_me = talk_to_me
	conversation_area.quest = quest
	
	if Player.adventure_log.get_adventures().size() > 0:
		if gone_after_quest and Player.adventure_log.get_adventure(quest.quest_id).completed:
			print("%s is gone because the adventure for the required adventure is already finished" % character_name)
			queue_free()
			
func _process(_delta):
	if Player.adventure_log.get_adventures().size() > 0:
		if gone_after_quest and Player.adventure_log.get_adventure(quest.quest_id).completed:
			print("%s is gone because the adventure for the required adventure is already finished" % character_name)
			
			queue_free()
		set_process(false)
	
func ready_creature_sprite(name):
	animation_player.play("%s_Idel" % [name])
	creature_sprites.get_node("%sIdel" % [name]).show()

func creature_battle_ready ():
	if battle_mode:
		print("NPC creature: ready tp battle: ", creature.name)
		
