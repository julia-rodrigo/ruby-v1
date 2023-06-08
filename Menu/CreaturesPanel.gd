extends Panel

#onready var top_box = $outerMargin/innerVbox/TopHbox
onready var creature_panel_info = $outerMargin/innerVbox/TopHbox/Info/about

# HP: 30/100
onready var health_label = $outerMargin/innerVbox/ContentMargin/SeparateMargin/CreatureProgress/HealthArea/Label
onready var health_progress_bar = $outerMargin/innerVbox/ContentMargin/SeparateMargin/CreatureProgress/HealthArea/HealthProgressBar

# EXP: 30/40
onready var EXP_label = $outerMargin/innerVbox/ContentMargin/SeparateMargin/CreatureProgress/EXPArea/Label
onready var EXP_progress_bar = $outerMargin/innerVbox/ContentMargin/SeparateMargin/CreatureProgress/EXPArea/ExperienceProgressBar

var selected_creature
var position 

func set_progress_bar(progress_bar, progress_bar_label, current_value, max_value, label):
	progress_bar.value = current_value;
	progress_bar.max_value = max_value;
	progress_bar_label.text = "%s:%s/%s" % [label, current_value, max_value]
	
func _process(_delta):
	if Creature.info_text_selected != null:
		creature_panel_info.text = Creature.info_text_selected
		Creature.info_text_selected = null
		update_creature_panel()	
		
	if Creature.selected != selected_creature:
		selected_creature = Creature.selected
		position = Creature.position
		update_creature_panel()	
		
	if Player.at_battle and position == Player.creature_position:
		set_progress_bar(health_progress_bar, health_label, Player.current_health, Player.max_health, "HP")
		set_progress_bar(EXP_progress_bar, EXP_label, Player.current_EXP, Player.max_EXP, "EXP")

func update_creature_panel ():
#	print("\nCreature panel: ", Creature.position)
#	print("Creature position panel: ", Creature.selected)
#	print("Creature position panel: ", Creature.selected)
#	if selected_creature != null:
		
#	print("current health: ", Creature.selected.current_health)
#	print("max health: ", Creature.selected.health)
#
#	print("current exp: ", Creature.selected.current_experience)
#	print("max exp: ", Creature.selected.experience)
	if Player.creaventory.get_creatures().size() > 0:
		set_progress_bar(health_progress_bar, health_label, Creature.selected.current_health, Creature.selected.health, "HP")
		set_progress_bar(EXP_progress_bar, EXP_label, Creature.selected.current_experience, Creature.selected.experience, "EXP")

func _on_CreaturesPanel_visibility_changed():
	
	update_creature_panel()
	pass # Replace with function body.
