extends Node


# this is the code to get all the creature files 
# from "res://Resource/Random/Creatures/"

var creatures = Array ()
func _ready():
	var directory = Directory.new()
	directory.open("res://Resource/Random/Creatures/") 
	directory.list_dir_begin () 
	
	var filename = directory.get_next()
	while (filename):
#		print("we are looking for: ", filename)
		if not directory.current_is_dir():
			creatures.append(load("res://Resource/Random/Creatures/%s" % filename))
		
		filename = directory.get_next()
		
# check if a creature exists

func get_creature (creature_name):
	for i in creatures:
#		print("we found: ", i.name)
		if i.name == creature_name:
			return i
		
	return null
