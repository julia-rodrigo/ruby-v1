extends Panel

# updating the quests that the player can see

# just change the panel on adventure log update or complete
onready var quest_panel = $outerMargin/innerVbox/TopHbox/Quest

onready var subtitle_label = quest_panel.get_node("contain/subtitle")
onready var title_label = quest_panel.get_node("contain/title")

# delete the child of this everytime
onready var scroll_container_to_change = $outerMargin/innerVbox/ContentMargin/SeparateMargin/Body/QuestContainer/Scroll

# to replace in the scroll container
onready var quest_container_list = preload("res://Menu/Menu_Panel/menu_quest_list.tscn").instance()


onready var require_label = quest_container_list.get_node("requirement/ProgressResult/content/require")
onready var amount_label = quest_container_list.get_node("requirement/ProgressResult/content/amount")
onready var quest_info_rich_text = quest_container_list.get_node("information/informationPanel/questInfo")

# amount of quests plus 1
onready var player_progress_bar_label = $outerMargin/innerVbox/ContentMargin/SeparateMargin/PlayerProgress/Label
onready var player_progress_bar = $outerMargin/innerVbox/ContentMargin/SeparateMargin/PlayerProgress/PlayerProgressBar

func _ready():
	var _not_in_use = Global.connect("player_initialised", self, "_on_player_initialised")
	_on_player_adventure_log_changed (Player.adventure_log)
	
func _on_player_initialised (_player):
	var _not_in_use = Player.adventure_log.connect("adventure_log_changed", self, "_on_player_adventure_log_changed")
	update_player_progress_bar(Quest.CURRENT_QUEST_ID)
	
func _on_player_adventure_log_changed (adventure_log):
	var quest = Quest.current_quest
#	print("The quest in menu panel: ", quest)
	
	if adventure_log.get_adventures().size() > 0 and quest != null:
		if quest.completed:
			title_label.text = "Post Adventure:"
			update_player_progress_bar(quest.quest_id + 1)
			
		else: # not completed
			title_label.text = "Ongoing Quest:"
			update_player_progress_bar(quest.quest_id)
			
		subtitle_label.text = quest.name
		if quest.adventure_reference.kind_of_adventure() == "Item":
			setNewItemAventure (quest)
		else:
			print("not an item adventure")
	else:
		print("No quest yet in the menu panel")

func setNewItemAventure (quest):
	
	var quest_reference = quest.adventure_reference
	
	require_label.text = quest.item_needed.name
	amount_label.text = "%d/%d" % [quest_reference.get_current_amount(), quest_reference.amount_to_collect]
	
	if quest.completed:
		quest_info_rich_text.text = quest.next_quest_hint
		amount_label.text = "%d/%d" % [quest_reference.amount_to_collect, quest_reference.amount_to_collect]	
	else:
		quest_info_rich_text.text = quest.description
	
	scroll_container_to_change.add_child(quest_container_list)
	reset_preload()
	
func reset_preload():
	quest_container_list = preload("res://Menu/Menu_Panel/menu_quest_list.tscn").instance()
	require_label = quest_container_list.get_node("requirement/ProgressResult/content/require")
	amount_label = quest_container_list.get_node("requirement/ProgressResult/content/amount")
	quest_info_rich_text = quest_container_list.get_node("information/informationPanel/questInfo")

func update_player_progress_bar(current_quest_id):
	var quests_completed = current_quest_id
	var full_game_completed = AdventureDatabase.adventures.size() + 1
	Global.set_progress_bar(player_progress_bar, quests_completed, full_game_completed)

static func _delete_children(node):
	for n in node.get_children():
		node.remove_child(n)
		n.queue_free()
