extends Spatial

#onready var creatures_array = Global.creature_encounter_list if Global.creature_encounter_list != null else []
#
#func _ready():
#	randomize()
#	var randomFinder = RandomFinder.new()
#	Global.encountered_creature = randomFinder.find_random_creature(creatures_array)
#	print(Global.encountered_creature)
