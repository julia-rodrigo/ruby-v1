extends MarginContainer

# check what creature is attive during battle

onready var selected_button = $Selected
onready var leader_button = $Leader
onready var status_button = $Status

var creature_selected
var position 

var selected = false
var status = "active"
var leader = false


func _ready():
	selected_button.hide()
	leader_button.hide()
	status_button.hide()
	

func _process(delta):
	if Creature.bag_creature_position == position:
		Creature.bag_creature_position = null
