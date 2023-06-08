extends VBoxContainer

# this is updating the creature UI names buttons when a new creature is captured

onready var creature_name_button = preload("res://Menu/Creature_Option/CreatureNameButton.tscn").instance()
var position = 0

func _ready():
	var _not_in_use = Global.connect("player_initialised", self, "_on_player_initialised")
	_on_player_creaventory_changed (Player.creaventory)
	
func _on_player_initialised (_player):
	var _not_in_use = Player.creaventory.connect("creaventory_changed", self, "_on_player_creaventory_changed")
	position = 0

func _on_player_creaventory_changed (creaventory):
	for n in get_children():
		n.queue_free()

	for creature in creaventory.get_creatures ():
		setNewItem(creature, creature.nickname)
		position += 1
	position = 0
#
func setNewItem (creature, creature_name):
	creature_name_button.position = position
	creature_name_button.text = creature_name
	creature_name_button.creature_info = creature
	
	add_child(creature_name_button)
	creature_name_button = preload("res://Menu/Creature_Option/CreatureNameButton.tscn").instance()

