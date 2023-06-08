extends HBoxContainer

# information on the creature

onready var creature_2D_sprite = $CreatureScreen/inner/Content/CreatureImage/Creature2DSprite
onready var creature_nickname_label = $CreatureFullStats/OuterMargin/ScrollContainer/List/NameArea/name
onready var creature_is_label = $CreatureFullStats/OuterMargin/ScrollContainer/List/CreatureArea/creature
onready var creature_level_label = $CreatureFullStats/OuterMargin/ScrollContainer/List/LevelArea/level
onready var creature_damage_label = $CreatureFullStats/OuterMargin/ScrollContainer/List/DamageArea/damage
onready var creature_defence_label = $CreatureFullStats/OuterMargin/ScrollContainer/List/DefenceArea/defence
onready var creature_tamer_label = $CreatureFullStats/OuterMargin/ScrollContainer/List/TamerArea/tamer
onready var creature_found_label = $CreatureFullStats/OuterMargin/ScrollContainer/List/FoundArea/found
onready var creature_initial_label = $CreatureFullStats/OuterMargin/ScrollContainer/List/InitialArea/initial
onready var creature_type_label = $CreatureFullStats/OuterMargin/ScrollContainer/List/TypeArea/type

onready var rename_button = $CreatureFullStats/OuterMargin/ScrollContainer/List/UserInput/Rename
onready var release_button = $CreatureFullStats/OuterMargin/ScrollContainer/List/UserInput/Release

var selected_creature
var position = 0

func _process(_delta):
	
	# updating any changes such as selected and the new nickname 
	# making sure some functionality cannot be used in battle
	
	if Player.creaventory.get_creatures().size() > 0:
		if selected_creature == null :
			selected_creature = Player.creaventory.get_creatures()[Creature.position]
			Creature.selected = selected_creature
	#		print("\nPlayer.creaventory.get_creatures()[0]: ", Player.creaventory.get_creatures()[0])
			setNewCreature(selected_creature, selected_creature.name)
		
		if Creature.selected != selected_creature:
			selected_creature = Creature.selected
			position = Creature.position
			setNewCreature(selected_creature, selected_creature.name)
			
		if Creature.new_nickname != null:
			creature_nickname_label.text = Creature.new_nickname
			Creature.new_nickname = null
		
		if Player.at_battle and Creature.update_creature != null:
			Creature.update_creature = null
			setNewCreature(selected_creature, selected_creature.name)
	
func setNewCreature (creature, creature_name):
	creature_2D_sprite.ready_creature_sprite(creature_name)
	creature_nickname_label.text = creature.nickname
	creature_is_label.text = creature.name
	creature_level_label.text = "%d" % creature.level
	creature_damage_label.text =  "%d" % creature.damage
	creature_defence_label.text =  "%d" % creature.defence
	creature_tamer_label.text = creature.tamer
	creature_found_label.text = creature.place_found
	creature_initial_label.text =  "%d" %  creature.initial
	creature_type_label.text = creature.type

func _on_Rename_pressed():
	if Player.at_battle:
		print("Focus on the battle first!")
	else:
		Creature.player_renaming = true

func _on_Release_pressed():
	if Player.at_battle:
		print("Focus on the battle first!")
	else:
		if Creature.leader_position == position:
			Creature.leader_position = null
		Creature.creature_released = true
		Player.creaventory.release_creature(position)	
		Player.creature_position = 0	
		position = 0
		Creature.selected = Player.creaventory.get_creature(0)
	
