extends CanvasLayer

onready var save_file = SaveFile.g_data

func _ready():
	$Menu/MarginContainer/VBoxContainer/Load.text = "load: %s" % [save_file.load]
	$Menu/MarginContainer/VBoxContainer/Restart.text = "restart: %s" % [save_file.restart]
	$Menu/MarginContainer/VBoxContainer/Settings.text = "settings: %s" % [save_file.settings]
	$Menu/MarginContainer/VBoxContainer/Quit.text = "quit: %s" % [save_file.quit]
	$Menu/MarginContainer/VBoxContainer/Save.text = "saved: %s" % [save_file.save]
	
func _on_Save_pressed():
	save_file.save += 1
	print("data saved: ", save_file.save)
	$Menu/MarginContainer/VBoxContainer/Save.text = "saved: %s" % [save_file.save]
	SaveFile.save_data();
	
func _on_Load_pressed():
	save_file.load = 1
	print("load: ", save_file.load)
	$Menu/MarginContainer/VBoxContainer/Load.text = "load: %s" % [save_file.load]

func _on_Restart_pressed():
	save_file.restart += 1
	save_file.save = 0
	save_file.settings = 0
	save_file.quit = 0
	save_file.load = 0
	
	print("restart: ", save_file.restart)
	
	$Menu/MarginContainer/VBoxContainer/Load.text = "load: %s" % [save_file.load]
	$Menu/MarginContainer/VBoxContainer/Restart.text = "restart: %s" % [save_file.restart]
	$Menu/MarginContainer/VBoxContainer/Settings.text = "settings: %s" % [save_file.settings]
	$Menu/MarginContainer/VBoxContainer/Quit.text = "quit: %s" % [save_file.quit]
	$Menu/MarginContainer/VBoxContainer/Save.text = "saved: %s" % [save_file.save]
	SaveFile.save_data();
	print(save_file)
	
func _on_Settings_pressed():
	save_file.settings += 1
	print("setteings: ", save_file.settings)
	$Menu/MarginContainer/VBoxContainer/Settings.text = "settings: %s" % [save_file.settings]
	
func _on_Quit_pressed():
	save_file.quit += 1
	print("quit: ", save_file.quit)
	$Menu/MarginContainer/VBoxContainer/Quit.text = "quit: %s" % [save_file.quit]
	SaveFile.save_data();
	get_tree().quit();
