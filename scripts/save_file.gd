extends Node
# https://www.youtube.com/watch?v=mV86a8TWSc4

# project settings > autoloads
const SAVE_FILE = "user://save_file.save"
var g_data = {}

func _ready():
	load_data()
	
func save_data():
	var file = File.new()
	print (g_data)
	file.open(SAVE_FILE, file.WRITE)
	file.store_var(g_data)
	file.close()
	
func load_data ():
	var file = File.new()
	if not file.file_exists(SAVE_FILE):
		g_data = {
			"save": 0,
			"load": 0,
			"restart": 0,
			"settings": 0,
			"quit": 0,
			"position": Vector3(0, 0, 0),
			# the player health and position and level 4 			
		}
		
		save_data()
	file.open(SAVE_FILE, file.READ)
	g_data = file.get_var()
	file.close()


