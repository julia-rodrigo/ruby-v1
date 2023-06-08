extends Node

export(Array, Resource) var creatures_array: Array = []

onready var randomFinder = $RandomFinder

func _ready():
	randomize()
	pass

func _physics_process(_delta):
	if Input.is_action_just_pressed("ui_accept"):
		print(randomFinder.find_random_creature())
