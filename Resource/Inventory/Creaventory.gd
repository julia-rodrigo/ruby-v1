extends Resource

class_name Creaventory 

signal creaventory_changed
export var _creatures = Array () setget set_creatures, get_creatures

func set_creatures (new_creatures):
	_creatures = new_creatures
	emit_signal ("creaventory_changed", self)

func get_creatures ():
	return _creatures

func get_creature (index): # single creature
	return _creatures [index]
	
func add_creature (creature_name): # add single creature
	
	var creature = CreatureDatabase.get_creature(creature_name)
	if not creature:
		print ("could not find creature Creaventory.gd: ", creature_name)
		return


	# A CREATURE DOESNT HAVE ANY STACKING OR STACK SIZE
	
	creature.tamer = Player.player_name
	creature.place_found = Global.current_level_name
	creature.initial = creature.level
	creature.nickname = creature.name	
	creature.available_attacks = creature.generate_creature_attacks()
	
#	print("HERE: ", creature.creature_info())
		
	var new_creature = save_creature_progress(creature)
	
	_creatures.append (new_creature)
		
	emit_signal("creaventory_changed", self) # Player.inventory

func add_creature_found (creature_resource): # add single creature
	
	var creature = CreatureDatabase.get_creature(creature_resource.name)
	if not creature:
		print ("could not find creature Creaventory.gd: ", creature_resource.name)
		return
	
	creature = creature_resource

	# A CREATURE DOESNT HAVE ANY STACKING OR STACK SIZE
	
	creature.tamer = Player.player_name
	creature.place_found = Global.current_level_name
	creature.initial = creature.level
	creature.nickname = creature.name

#	print("\n this it the creature we will add", creature.creature_info())
	
#	"name": name,
#		"nickname": nickname,		
#		"health": health,	
#		"current_health": current_health,	
#		"experience": experience,	
#		"current_experience": current_experience,	
#		"damage": damage,
#		"level": level,
#		"initial": level,
#		"place_found": place_found,
#		"tamer": tamer,	
#		"available_attacks": get_creature_attacks ()
		
	# save creature data since the base wil always stay the same
	var new_creature = save_creature_progress(creature)
	
	_creatures.append (new_creature)
	
#	print("\nadded new creature! Check the kiddo out in your Creature: ", creature.name)
	
	
	emit_signal("creaventory_changed", self) # Player.inventory

func add_wild_creature_found (wild_creature): 
	
	var creature = CreatureDatabase.get_creature(wild_creature.name)
	if not creature:
		print ("could not find creature Creaventory.gd: ", wild_creature.name)
		return
		
	wild_creature.tamer = Player.player_name
	
	if(wild_creature.creature_reference.item):
		var item = wild_creature.creature_reference.item
		print("%s is holding an item: %s" % [wild_creature.name, item.name] )
		Player.inventory.add_item(item.name, 1)
	
	_creatures.append (wild_creature)
	emit_signal("creaventory_changed", self) 

func save_creature_progress (creature):
	return {
		creature_reference = creature,		
		name = creature.name,
		nickname = creature.nickname,
		health = creature.health,
		current_health = creature.current_health,
		experience = creature.experience,
		current_experience = creature.current_experience,
		damage = creature.damage,
		defence = creature.defence,
		type = creature.type,
		level = creature.level,
		initial = creature.initial,
		place_found = creature.place_found,
		tamer = creature.tamer,
		description = creature.description,
		available_attacks = creature.available_attacks
	}
	
func player_creature_info_changed (position, creature): # position and the creature itself
	_creatures[position] = {
		creature_reference = creature.creature_reference,		
		name = creature.name,
		nickname = creature.nickname,
		health = creature.health,
		current_health = creature.current_health,
		experience = creature.experience,
		current_experience = creature.current_experience,
		damage = creature.damage,
		defence = creature.defence,
		level = creature.level,
		type = creature.type,		
		initial = creature.initial,
		description = creature.description,		
		place_found = creature.place_found,
		tamer = creature.tamer,
		available_attacks = creature.available_attacks
	}
	
#	print("creature current health: ", creature.current_health)
	
	
	emit_signal("creaventory_changed", self) 


func release_creature (position): # subtract item by amount
	if position == 0: 
		print("you cannot release your first creature: ", _creatures[position].nickname)
		return
		
	if _creatures.size() == 1:
		print("you only have one creature left! you can't release it")
		return
	
	if(position > (_creatures.size() - 1)):
		print("cannot remove item amount at: ", position)
		return
		
	var release_creature = _creatures[position]

	print ("position: ", position)
	print ("creature nickname: ", release_creature.nickname)

	_creatures.remove(position)
#	Creature.updated_tamer_list = _creatures
	
	
	
	print("GOOD BYE: ", release_creature.nickname)
	print("SIZE IN CREATURES : ",_creatures.size())
	emit_signal("creaventory_changed", self)
	
