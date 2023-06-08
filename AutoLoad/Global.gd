extends Spatial

# check the available creature in the world export array
var creature_encounter_list = []
var encountered_creature = {}

# get the world path and the name of the world
var current_world_filepath
var current_level_name

# check if the player came from the level or from the grass 
# so that we could save the player position
var from_level
var from_Grass = false

# get the player position and the animation
var PlayerPosition
var idelName

# get the player position at the sign area and the level area
# save the health found

var PlayerPosition_SignSave
var LevelPathway_SignSave

var SignSave_PlayerHealth
var LevelName_SignSave

# this code is to check the player help save area. 
# But is not being used as of the current game, just being printed off the terminal
var PlayerPosition_HelpSave
var LevelPathway_HelpSave
var HelpSave_PlayerHealth
var LevelName_HelpSave

# this is the path to the battle system
var battle_level_path
var battle_path

# check if you are going to battle in the outer grass or the inner grass part
var back_from_battle
var back_from_battle_Inner

var auto_move_direction
var auto_move_run_sprite

# save your help preference menu viewer
var help_preferences = true

# get the saved resources path of the game system
var inventory_save_path = "res://SAVED_GAME_FILES/inventory.tres"
var creaventory_save_path = "res://SAVED_GAME_FILES/creaventory.tres"
var adventure_log_save_path = "res://SAVED_GAME_FILES/adventure_log.tres"

# update any progress bar
func set_progress_bar(progress_bar, current_value, max_value):
	progress_bar.value = current_value;
	progress_bar.max_value = max_value;
	
# update any progress bar label
func set_progress_bar_label (progress_bar_label, current_value, max_value, progress_bar_text):
	progress_bar_label.text = "%s: %s/%s" % [progress_bar_text, current_value, max_value, ]
	
# check what food item sprite in the bag has been used before the panel updates
# when the panel updates, put that sprite in the section that the user dropped it in
var bag_item_sprite
var bag_item_panel_position
var bag_item_position_in_panel
var bag_item_selected_info

# check if the keyboard option are disabled
var disable_keyboard_options
	
# get ready a the player initialise signal 
signal player_initialised

# this is the player body
var player

# this is the name of the current scene
var current_scene_name

func _process(_delta):
	
	# check if a player exists
	if not player:
		print("CURRENT WORLD: ", current_level_name)
		initialise_player ()
		return

# for making sure there are no errors once the scene changes
func disconnect_player():
	Player.inventory.disconnect("inventory_changed", self, "_on_player_inventory_changed")
	Player.creaventory.disconnect("creaventory_changed", self, "_on_player_creaventory_changed")
	Player.adventure_log.disconnect("adventure_log_changed", self, "_on_player_adventure_log_changed")
	
	player = null

# when the scene changes emit a player initialisation to connect all the functions below	
func initialise_player():
	player = get_tree().get_root().get_node("/root/" + current_scene_name + "/Ruby")
	
	emit_signal("player_initialised", player)
	
	Player.inventory.connect("inventory_changed", self, "_on_player_inventory_changed")
	Player.creaventory.connect("creaventory_changed", self, "_on_player_creaventory_changed")
	Player.adventure_log.connect("adventure_log_changed", self, "_on_player_adventure_log_changed")
	
	
	var directory = Directory.new();
	
	var existing_inventory = directory.file_exists(inventory_save_path)
	var existing_creaventory = directory.file_exists(creaventory_save_path)
	var existing_adventure_log = directory.file_exists(adventure_log_save_path)
	

	if existing_inventory:
		existing_inventory = load(inventory_save_path)
#		print("Existing items: ", existing_inventory.get_items())
		Player.inventory.set_items(existing_inventory.get_items()) # GET ITEMS WITH AN 'S'
		print("an inventory exists")
	else:
		# lets give the player 3 pieces of apple
#		Player.inventory.add_item("Apple", 10)
		print("no inventory exists...")
		
	if existing_creaventory:
		existing_creaventory = load(creaventory_save_path)
		Player.creaventory.set_creatures(existing_creaventory.get_creatures()) # GET ITEMS WITH AN 'S'
		
#		print("first creature attacks: ", Player.creaventory.get_creatures()[1].available_attacks)
		print("a creaventory exists")
		
	else:
		# lets give the player 3 pieces of apple
#		Player.creaventory.add_creature("Feet")
#		Player.creaventory.add_creature_found(Player.randomFinder.find_random_creature(Global.creature_encounter_list).resource)
		print("no creatures yet..")
		
	if existing_adventure_log:
		existing_adventure_log = load(adventure_log_save_path)
		Player.adventure_log.set_adventures(existing_adventure_log.get_adventures()) # GET ITEMS WITH AN 'S'
		print("aN adventure_log exists")
		
	else:
		# lets give the player 3 pieces of apple
#		Player.adventure_log.add_adventure("Something's Wrong")
		print("no adventures yet..But you can talk to tihi for one")
		
# saved functions
func _on_player_inventory_changed(inventory):
	var _not_in_use = ResourceSaver.save(inventory_save_path, inventory)
		
func _on_player_creaventory_changed(creaventory):
#	print("creaventory saved: ", Player.creaventory.get_creatures())
	var _not_in_use = ResourceSaver.save(creaventory_save_path, creaventory)
	
func _on_player_adventure_log_changed(adventure_log):
	var _not_in_use = ResourceSaver.save(adventure_log_save_path, adventure_log)
		
