extends Button

# this code is working with the individual creature panel in the bag section [A].

# ready some tags names from the current bag
onready var panel_of_sprite = $inner/Content/CreatureImage/Panel
onready var activity_buttons_container = $inner/Content/NameArea/activity

onready var selected_button = activity_buttons_container.get_node("Selected")
onready var leader_button = activity_buttons_container.get_node("Leader")
onready var status_button = activity_buttons_container.get_node("Status")

# check the positon of the creature being selected and check if fainted currently
var position
var creature 
var fainted = false
var selected

# check the leader of the team (ie the first creature to go into battle)
var leader  

# check the current selected panel
var panel_selected = false

onready var health_label = $inner/Content/HealthArea/health
onready var health_bar = $inner/Content/HealthArea/healthBar

func _ready():
	
	# update the progress bar
	Global.set_progress_bar(health_bar, creature.current_health, creature.health)
	Global.set_progress_bar_label(health_label, creature.current_health, creature.health, "HP")

	# hide some buttons depending on the creature
	selected_button.hide()
	leader_button.hide()
	status_button.hide()
	
	# check if creature fainted
	show_status_button()
	
	# see if the creature is at the leader position or not
	if Creature.leader_position == position:
		leader_button.show()
		leader = position
		
	# check if the player is feeding the creature an item
	if Global.bag_item_sprite and position == Global.bag_item_panel_position:
#		print("added the sprite")
		panel_of_sprite.add_child(Global.bag_item_sprite)
		Global.bag_item_sprite = null
		Global.bag_item_panel_position = null
		
	panel_of_sprite.panel_position = position
	pass

	
func _process(_delta):
	
	# check if the player selected the creature
	if selected != null and Creature.bag_creature_position != position:
		selected_button.hide()
		selected = null
		panel_selected = false
	
	# check if the player selected the creature as the leader	
	if leader != null and Creature.leader_position != position:
		leader_button.hide()
		leader = null
		panel_selected = false
		
	# check if the player is at battle 
	if Player.at_battle and Player.creature_position == position:
		selected_button.hide()
		leader_button.hide()
		
		
func show_selected_button():
	selected_button.show()
	Creature.bag_selected_creature = creature
	Creature.bag_creature_position = position
	selected = true

func show_status_button ():
	if creature.current_health == 0:
		status_button.text = "Fainted"
		status_button.show()
		fainted = true
		
	else:
		if Player.at_battle and Creature.leader_position == position:
			status_button.text = "Active"
			status_button.show()
		else:
			status_button.hide()
			
		fainted = false


func show_leader_button ():
	pass

func _on_Selected_pressed():
	
	leader_button.show()
	selected_button.hide()
	
	Creature.leader_position = position
	leader = true
	
	pass # Replace with function body.


func _on_Leader_pressed():
	
	leader_button.hide()
	show_selected_button()
	selected = true
	panel_selected = true
	Creature.leader_position = 0
	
	
	
	pass # Replace with function body.


func _on_Status_pressed():
	
	pass # Replace with function body

func _on_Creature_pressed():
#	print("on crature pressedd")
	selected = true
	Creature.bag_selected_creature = creature
	Creature.bag_creature_position = position
	
	if not fainted and not leader_button.visible:
		show_selected_button()
		
	if not fainted and Creature.select_during_battle_on != null:
		Creature.battle_creature_selected_position = position
		Creature.select_during_battle_on = null
#		print("selected, ", creature.nickname)
		
		
	if panel_selected:
		panel_selected = false
		selected_button.hide()
	else:
		panel_selected = true
	
	
	



