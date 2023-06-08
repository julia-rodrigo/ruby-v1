extends Node

# this is the code to get all the adventure files 
# from "res://Resource/Adventures/Adventure/"

var adventures = Array ()
func _ready():
	var directory = Directory.new()
	directory.open("res://Resource/Adventures/Adventure/") 
	directory.list_dir_begin () 
	
	var filename = directory.get_next()
	while (filename):
#		print("we are looking for: ", filename)
		if not directory.current_is_dir():
			adventures.append(load("res://Resource/Adventures/Adventure/%s" % filename))
		
		filename = directory.get_next()
		
# check if the adventure exists

func get_adventure (adventure_name):
	for i in adventures:
		print("we found the adventure: ", i.name)
		if i.name == adventure_name:
			return i
		
	return null
