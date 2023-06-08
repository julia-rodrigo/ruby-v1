extends Node
export(Array, Resource) var creatures_array: Array = []

func _ready():
	randomize()
	pass

func _physics_process(_delta):
	if Input.is_action_just_pressed("ui_accept"):
		var randomFinder = RandomFinder.new()
		print(randomFinder.find_random_creature(creatures_array))
