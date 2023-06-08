extends HBoxContainer

# instance a scene on ready and target some variables in that scene so we could
# pass some data on ready 

onready var newCreature = preload("res://Menu/Bag/BagCreature.tscn").instance()
onready var creature_name_label = newCreature.get_node("inner/Content/NameArea/name")
onready var creature_health_label = newCreature.get_node("inner/Content/HealthArea/health")
onready var creature_health_bar = newCreature.get_node("inner/Content/HealthArea/healthBar")
onready var creature_2D_sprite = newCreature.get_node("inner/Content/CreatureImage/Creature2DSprite")

# posiiton of the creature
var position = 0

# use the creature function and connect it to the existing creature in the save files
func _ready():
	var _not_in_use = Global.connect("player_initialised", self, "_on_player_initialised")
	_on_player_creaventory_changed (Player.creaventory)	
	
func _on_player_initialised (_player):
	var _not_in_use = Player.creaventory.connect("creaventory_changed", self, "_on_player_creaventory_changed")
	position = 0
	
# everytime the creaventory is updated, so will your list of creature in the bag section [A]
func _on_player_creaventory_changed (creaventory): # delete the current bag item and add updated inforomation
	for n in get_children():
		n.queue_free()
	
	for creature in creaventory.get_creatures ():
		setNewCreature(creature, creature.name)
		position += 1
	
	position = 0

# set the new information everytime the scene starts
func setNewCreature (creature, creature_name):
	
#	print("creature in the bag: ", creature_name)
	creature_2D_sprite.ready_creature_sprite(creature_name)
	creature_name_label.text = creature.nickname
	
	Global.set_progress_bar(creature_health_bar, creature.current_health, creature.health)
	Global.set_progress_bar_label(creature_health_label, creature.current_health, creature.health, "HP")
	
	newCreature.position = position
	newCreature.creature = creature
	add_child(newCreature)
	
	# make sure to reload the instances as they are used already 
	newCreature = preload("res://Menu/Bag/BagCreature.tscn").instance()
	creature_name_label = newCreature.get_node("inner/Content/NameArea/name")
	creature_health_label = newCreature.get_node("inner/Content/HealthArea/health")
	creature_health_bar = newCreature.get_node("inner/Content/HealthArea/healthBar")
	creature_2D_sprite = newCreature.get_node("inner/Content/CreatureImage/Creature2DSprite")
