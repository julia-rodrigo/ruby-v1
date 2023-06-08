extends Button

onready var user_input = $UserInput

var creature_info
var position

# everything to do with the creature selection in the [S] panel. renaming and releasing

func _ready():
	user_input.hide()

func _process(_delta):
	if Creature.player_renaming != null and position == Creature.position:
		user_input.show()
		user_input.text = Creature.selected.nickname
		user_input.grab_focus()
		user_input.set_cursor_position(len(text))
		
		Creature.player_renaming = null
		Global.disable_keyboard_options = true
		Player.move = false
		
	
func _on_CreatureNameButton_pressed():
#	print("\ncreature_info: ", creature_info)
#	print("position: ", position)
	
	Creature.selected = creature_info
	Creature.position = position
	Creature.info_text_selected = Creature.selected.creature_reference.description
	print("creature info: ", Creature.info_text_selected)
	
	pass # Replace with function body.

func _on_UserInput_text_entered(new_nickname):
#	Creature.selected.nickname = new_nickname
	
	var creature_changed = Player.creaventory.get_creature(position)
	creature_changed.nickname = new_nickname
	
	Player.creaventory.player_creature_info_changed (position, creature_changed)
	Creature.new_nickname = new_nickname
	user_input.hide()
	Player.move = true
	
	Global.disable_keyboard_options = false
	
func _on_UserInput_focus_exited():
	user_input.release_focus()	
	user_input.hide()
	
	Player.move = true	
	Global.disable_keyboard_options = false	
