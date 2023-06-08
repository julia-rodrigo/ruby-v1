extends VBoxContainer

# updating the attack list in the creatures panel [S]

onready var attack_line = preload("res://Menu/Creature_Option/AttackLine.tscn").instance()
onready var attack_line_name_button = attack_line.get_node("Description/Attack")
onready var attack_line_strength_label = attack_line.get_node("Description/Stats/strength")

var position = 0
var previous_creature_position
var creature_release_offset = 0

func _process(_delta):
		
	if previous_creature_position == null :
		previous_creature_position = Creature.position
		set_creature_attacks_info()
		
	if (Creature.position != previous_creature_position):
		previous_creature_position = Creature.position
		set_creature_attacks_info()
		
	if Creature.creature_released != null:
		Creature.creature_released = null
		Creature.position = Creature.position -1
		
func set_creature_attacks_info ():
	for n in get_children():
		n.queue_free()
	
#	if Player.at_battle:
#		print("checking errprs: ", Player.creaventory.get_creatures().size())
		
	if Player.creaventory.get_creatures().size() > 0 :
		for creature_attack in Player.creaventory.get_creatures()[Creature.position].available_attacks:
			setNewAttack(creature_attack)
			position += 1
		position = 0
	
#
func setNewAttack (creature_attack):
	
#	print("HERE ARE THE ATTACK: ", creature_attack.name)
	attack_line_name_button.text = creature_attack.name
	attack_line_strength_label.text = "dmg: %s" % creature_attack.damage
	
	attack_line.attack = creature_attack
	attack_line.attack_name = creature_attack.name
	attack_line.attack_info = creature_attack.description
	attack_line.attack_damage = creature_attack.damage

	add_child(attack_line)
	attack_line = preload("res://Menu/Creature_Option/AttackLine.tscn").instance()
	attack_line_name_button = attack_line.get_node("Description/Attack")
	attack_line_strength_label = attack_line.get_node("Description/Stats/strength")
