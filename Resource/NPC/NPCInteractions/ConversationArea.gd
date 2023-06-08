extends Area

onready var dialogue_box = preload("res://Resource/NPC/NPCInteractions/NPCDialogues/DialogueBox.tscn").instance()
onready var character_name_label = dialogue_box.get_node("outer/Panel/inner/list/name")

onready var talk_panel = $Control/MarginContainer/center/TalkToMe
onready var control_node = $Control

var character_name = "NO CHARACTER NAME!"
var message = [ "NO MESSEAGES EITHER", "oops", "I WONDER WHY"]
var talk_to_me = "interact"

var can_interact = false
var quest
var battle_ready
var tamer_team
var challenger_post_message

var player_body 

func _ready():
	
		
	talk_panel.get_node("inner/separate/press").text = talk_to_me
	talk_panel.hide()

func _on_ConversationArea_body_entered(body):
	if body.name == 'Ruby':
		player_body = body 
		talk_panel.show()
		can_interact = true

func _on_ConversationArea_body_exited(body):
	if body.name == 'Ruby':
		talk_panel.hide()
		can_interact = false

func _input(_event):
	
	if Input.is_key_pressed(KEY_W) and can_interact:
		
		if quest != null:
			get_quest()
		else:
			print("There is no quest here with ", character_name)
		
		dialogue_box.dialogue = message
		dialogue_box.name_of_character = character_name
		add_child(dialogue_box)
		
		if battle_ready:
			dialogue_box.connect("dialogue_ended", self, "battle_start")
	
		dialogue_box = preload("res://Resource/NPC/NPCInteractions/NPCDialogues/DialogueBox.tscn").instance()

func get_quest ():

	if Quest.CURRENT_QUEST_ID > quest.quest_id:
		message = quest.post_quest_message
		return

	if Quest.CURRENT_QUEST_ID != quest.quest_id:
		print("your current quest doesnt match the current id %d != %d  " % [Quest.CURRENT_QUEST_ID, quest.quest_id])
		return

	if Player.adventure_log.get_adventures().size() >= 0:
		var new_quest = Player.adventure_log.get_adventure_by_name(quest.name)
		if new_quest != null:
			print('you already have this adventurue: ', new_quest)
			check_quest_completed(new_quest)
			return

		Player.adventure_log.add_adventure(quest.name)
#		print("\n\nCurrent adventure: ", Quest.current_quest)
#		print("Current id: ", Quest.CURRENT_QUEST_ID)

	#	print("YOU NOW HAVE AN ADVENTURE!!!!: ", quest.get_additional_quest_info())
		print("here")
	else:
		print("no adventures yet cause of null")
		return



func check_quest_completed(current_quest):
	if current_quest.completed:
		message = current_quest.post_quest_message
		return

	if Player.adventure_log.get_adventure(quest.quest_id).adventure_reference.kind_of_adventure() == "Item":
		print("here2")

		if not battle_ready and Player.inventory.get_item_by_name(quest.item_needed.name) and not Player.adventure_log.get_adventure(quest.quest_id).completed:
			print("here3")

			dialogue_box.dialogue = quest.post_quest_message
			dialogue_box.name_of_character = character_name
			add_child(dialogue_box)
			message = quest.post_quest_message

			var completed_quest = Player.adventure_log.get_adventure_by_name(quest.name).adventure_reference

			if not completed_quest.completed:
				Player.inventory.subtract_item_by_name(completed_quest.item_needed.name, completed_quest.amount_to_collect)						
				completed_quest.completed_quest()
				completed_quest.collect_reward()
				Player.adventure_log.player_adventure_info_changed(completed_quest.quest_id, completed_quest)
				Quest.CURRENT_QUEST_ID += 1

				print("Quest.CURRENT_QUEST_ID updated to: ", Quest.CURRENT_QUEST_ID)

			dialogue_box = preload("res://Resource/NPC/NPCInteractions/NPCDialogues/DialogueBox.tscn").instance()

func battle_start():
	print("battle ready: first buff up chllenger tamer team")
	var parent_name = $"../../".get_parent()
	
	print("parent_name: ", parent_name)
	
	Quest.challenger_name = character_name
	Quest.challenger_tamer_team = Quest.buff_up_tamer_team(tamer_team, 3)
	
	print("CHJVRQL NTERO TBELRI tamer tea,, ", Quest.challenger_tamer_team[0])
	
	Quest.challenger_post_message = challenger_post_message
	Quest.challenger_current_creature = Quest.challenger_tamer_team[0]
	
	Global.from_Grass = $"../../".get_parent().name
	Global.PlayerPosition = player_body.global_transform.origin
	visible = false
	Global.battle_level_path = parent_name.filename
	
	Player.at_battle = true
	
	print("Global.battle_level_path: ", Global.battle_level_path)
	
	Global.disconnect_player()
	var _not_in_use = get_tree().change_scene("res://World/NPCBattleEncounter/NPCBattle_" + parent_name.name + ".tscn")
