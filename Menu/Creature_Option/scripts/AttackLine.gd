extends MarginContainer

# anuthing to do with select the creature attacks

var attack_name
var attack_info
var attack_damage
var attack

func _on_Attack_pressed():
	Creature.info_text_selected = attack_info
	print("%s deals %d damage: %s" % [attack_name, attack_damage, attack_info])
