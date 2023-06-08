extends CanvasLayer

# this is saving all the options for when the player selects a panel to look at

#onready var save_file = SaveFile.g_data
export var mainGameScene : PackedScene

onready var save_button = $Options/TopMarginContainer/SideMarginContainer/ButtonOptions/Button3/MarginContainer/SaveButton
onready var menu_button = $Options/TopMarginContainer/SideMarginContainer/ButtonOptions/Button5/MarginContainer/MenuButton
onready var bag_button = $Options/TopMarginContainer/SideMarginContainer/ButtonOptions/Button1/MarginContainer/BagButton
onready var creature_button = $Options/TopMarginContainer/SideMarginContainer/ButtonOptions/Button2/MarginContainer/CreatureButton

onready var text_box = $Options/TextBox

onready var bag_panel = $fillSizeFlags/marginBottomAndFillOnly/BagPanel
onready var creatures_panel = $fillSizeFlags/marginBottomAndFillOnly/CreaturesPanel
onready var menu_panel = $fillSizeFlags/marginBottomAndFillOnly/MenuPanel

var panel_being_viewed = null
var new_panel_view = null


func _ready():
#	print("help preferene: ", Global.help_preferences)
	$Options.visible = false if Global.help_preferences == false else true
	save_button.disabled = true if Player.at_battle else false
	menu_button.disabled = true if Player.at_battle else false
	
func _input(event):
#	if ev is InputEventKey and ev.scancode == KEY_M and not ev.echo:
	if( not Global.disable_keyboard_options):
		if event is InputEventKey:
			if event.is_pressed() == false:
				match event.scancode :
					KEY_A:
						bag_preference()
					KEY_S:
						creature_preference()
					KEY_D:
						save_preference()
					KEY_F:
						menu_preference()	
					KEY_G:
						options_preference()
					KEY_E:
						Player.inventory.add_item("Golden Apple", 1)
						Player.inventory.add_item("Apple", 10)
						
						
#						Player.creaventory.add_creature("Hasven")
#						Player.get_inventory_items()
#						Player.inventory.subtract_item(Player.inventory.get_item(0), 1)

#						Player.inventory.subtract_item(0, 1) # subtract item in this position, and the mount
						

	#				KEY_UP:
	#					print("face back")
	#
	#				KEY_DOWN:
	#					print("face front")
	#
	#				KEY_LEFT:
	#					print("face left")
	#
	#				KEY_RIGHT:
	#					print("face right")

					_:
	#					print("Another key'!! :)")
						pass




func _on_BagButton_pressed():
	bag_preference()


func _on_CreatureButton_pressed():
	creature_preference()


func _on_SaveButton_pressed():
	save_preference()
	


func _on_MenuButton_pressed():
	menu_preference()


func _on_OptionsButton_pressed():
	options_preference()

func save_preference():
	if not Player.at_battle and Player.move:
		print("Save")		
		print("player position at save: ", get_node("../../Ruby").global_transform.origin)
		Global.PlayerPosition_HelpSave = get_node("../../Ruby").global_transform.origin
		Global.LevelPathway_HelpSave = Global.current_world_filepath
		Global.HelpSave_PlayerHealth = Player.current_health
		Global.LevelName_HelpSave = Global.current_level_name
				
		Player.save_current_stats()
		
		$Options/SavingPanel.show()	
		timerYield(0.4)
	else:
		print("Cannot save right now!")
		var text = "hmm kinda hard to focus right now! Maybe later"
		display_text(text)
	

func timerYield(cooldown):
	print("self: ", self)
	var _not_in_use = get_tree().create_timer(cooldown).connect("timeout", self, "saveTimer")	

func saveTimer():
	print("timer")
	$Options/SavingPanel.hide()	
	
func display_text (text):
	$Options/TextBox/MarginContainer/Label.text = text	
	text_box.show()	
	timerYieldTextbox(0.5)
	
func timerYieldTextbox(cooldown):
	var _not_in_use = get_tree().create_timer(cooldown).connect("timeout", self, "textBoxHideAfterTimer")
	
func textBoxHideAfterTimer():
	text_box.hide()
	
func options_preference():
	print("Options")
	
	if $Options.visible:
		$Options.visible = false
		Global.help_preferences = false
	else:
		$Options.visible = true
		Global.help_preferences = true

func menu_preference() :
	if not Player.at_battle :
		print("Menu")
		new_panel_view = menu_panel
		panel_viewing()
	else:
		print("Now is not the time!")
		display_text("Now is not the time! Need to concentrate :<")
	
		

func bag_preference():
	print("Bag")
	new_panel_view = bag_panel
	panel_viewing()
	pass


func creature_preference() :
	print("Creatures")	
	if Player.creaventory.get_creatures().size() > 0:
		creatures_panel.update_creature_panel()
	
	new_panel_view = creatures_panel
	panel_viewing()
	
onready var other_panels_view = $fillSizeFlags

func panel_viewing():
	
	if panel_being_viewed == null:
		other_panels_view.visible = true
		panel_being_viewed = new_panel_view
		panel_being_viewed.visible = true
		Player.move = false
		
	elif new_panel_view == panel_being_viewed:
		other_panels_view.visible = false		
		new_panel_view.visible = false
		panel_being_viewed = null
		new_panel_view = null
		Player.move = true
		
		
	elif(new_panel_view != panel_being_viewed):
		panel_being_viewed.visible = false
		panel_being_viewed = new_panel_view
		new_panel_view.visible = true
		Player.move = false
		
	else:
		print("ERROR")
	
	
	
		

