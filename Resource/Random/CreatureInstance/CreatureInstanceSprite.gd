extends Spatial
onready var creature_info = Player.creatures[Player.creature_position]
onready var sprite = creature_info.sprite
onready var sprite_instance = sprite.instance()

func _ready():
	print("creature instances!: ", creature_info.creature_info())
	add_child(sprite_instance)
	get_node("EnemyBattleSprite").ready_creature_sprite(creature_info.name)
	pass
