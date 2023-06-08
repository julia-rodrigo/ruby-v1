extends Spatial

# during the npc battle at the end

signal dialogue_closed
var out_of_battle = Global.battle_level_path

var player_turn = false
var textbox_cooldown = 0.5

var creature_position = Creature.select_health_creature_position()
var player_partner

onready var text_box = get_node("Control/TextBoxArea")
onready var actionPanel = get_node("Control/MarginContainer/Scene/ActionPanel")

onready var playerPanel = $Control/MarginContainer/Scene/Field/MarginContainer/Versus/PlayerPanel
onready var enemyPanel = $Control/MarginContainer/Scene/Field/MarginContainer/Versus/EnemyPanel

onready var player = $Control/MarginContainer/Scene/Field/MarginContainer/Versus/PlayerPanel/Player
onready var opponent = $Control/MarginContainer/Scene/Field/MarginContainer/Versus/EnemyPanel/Opponent

onready var player_name_label = playerPanel.get_node("container/name")
onready var player_level_label = playerPanel.get_node("container/content/MarginContainer/VBoxContainer/Level")
onready var player_health_label = playerPanel.get_node("container/content/MarginContainer/VBoxContainer/Health")
onready var player_hp_progress = playerPanel.get_node("container/content/VBoxContainer/line/HP")
onready var player_exp_progress = playerPanel.get_node("container/content/VBoxContainer/EXP")
onready var player_dizziness_progress = playerPanel.get_node("container/content/VBoxContainer/Dizziness")
onready var player_partner_sprite = playerPanel.get_node("Partner")

onready var enemy_name_label = enemyPanel.get_node("container/name")
onready var enemy_level_label = enemyPanel.get_node("container/content/MarginContainer/VBoxContainer/Level")
onready var enemy_health_label = enemyPanel.get_node("container/content/MarginContainer/VBoxContainer/Health")
onready var enemy_hp_progress = enemyPanel.get_node("container/content/VBoxContainer/line/HP")
onready var enemy_creature_sprite = enemyPanel.get_node("Enemy")

onready var attack1_button = $Control/MarginContainer/Scene/ActionPanel/Attack1
onready var attack2_button = $Control/MarginContainer/Scene/ActionPanel/Attack2
onready var heal_button = $Control/MarginContainer/Scene/ActionPanel/Heal
onready var catch_button = $Control/MarginContainer/Scene/ActionPanel/Catch

var waiting = false

var current_creature = Quest.challenger_current_creature

func _process(_delta):
	if Player.player_partner_used_item != null and Player.item_used != null:
		print("You gave %s some %ss!" % [player_partner.nickname, Player.item_used.item_reference.name])
		Player.player_partner_used_item = null
		Player.item_used = null
		Player.recover_from_dizziness = true
		ready_player_partner()
	
	if waiting == true and Creature.battle_creature_selected_position != null:
		waiting = false
		print("watiing for a selection")
		continue_battle()

func _ready():
	Quest.challenger_team_position = 0
	print("current_creature: OUCH ", Quest.challenger_team_position)
	
	print("\nnpc creature: ", Quest.challenger_current_creature)
	print("npc creature: ", current_creature.creature_name)
	Global.back_from_battle = true # IMPORTANT
	Global.back_from_battle_Inner = true
	Global.current_scene_name = get_parent().name
	
	if (Creature.leader_position != null and Player.creaventory.get_creatures()[Creature.leader_position].current_health > 0):
		creature_position = Creature.leader_position
		

	text_box.hide()
	actionPanel.hide()
	playerPanel.hide()
	enemyPanel.hide()


	ready_enemy_creature_sprite()
	ready_player_partner()

	show_player()
	show_enemy()


func ready_enemy_creature_sprite():
#	display_text("%s send out %s" % [Quest.challenger_name, Quest.challenger_current_creature])
	
	enemy_creature_sprite.get_node("KinematicBody").get_node("%sIdel" % [current_creature.creature_name]).show()
	enemy_creature_sprite.get_node("KinematicBody/AnimationPlayer").play("%s_Idel" % [current_creature.creature_name])

	enemy_name_label.text = current_creature.creature_name
	enemy_level_label.text = "Lv. %d" % [current_creature.level]
	
	set_health(enemy_hp_progress, current_creature.current_health, current_creature.health)
	

func ready_player_partner():
	player_partner = Player.creaventory.get_creature(creature_position)
	print("READY PLAYER PARTNER: ", creature_position)
	Player.creature_name = player_partner.name
	Player.damage = player_partner.damage
	Player.max_EXP = player_partner.experience	
	Player.current_EXP = player_partner.current_experience
	Player.level = player_partner.level
	Player.available_attacks = player_partner.available_attacks

	attack1_button.text = Player.available_attacks[0].name
	attack2_button.text = Player.available_attacks[1].name
	
	Player.max_health = player_partner.health
	Player.defence = player_partner.defence
	Player.current_health = player_partner.current_health

	print("READY PLAYER PARTNER attacks: ", Player.available_attacks)

	print("creature level: ", player_partner.level)
	player_level_label.text = "Lv. %s" % Player.level
	player_name_label.text = player_partner.nickname

	update_player_dizziness()
	update_creature_experience_progress()
	update_creature_stats()
	set_health(player_hp_progress, Player.current_health, Player.max_health)
	

func update_player_dizziness ():
	Global.set_progress_bar(player_dizziness_progress, Player.current_dizziness, Player.max_dizziness)

func update_creature_experience_progress ():
	Global.set_progress_bar(player_exp_progress, Player.current_EXP, Player.max_EXP)

func swap_creature (swap_position):

	print("\n\nswap_position: ", swap_position)
	print("creature_position: ", creature_position)


	creature_position = swap_position
	player_partner = Player.creaventory.get_creature(creature_position)
	
	ready_player_partner()

	print("creature_health: ", player_partner.health)

func gain_experience_from_fight ():
	var gained_experience = max(5, current_creature.experience - Player.level*1.2)
	display_text("%s gained %d experience!!.." % [Player.creature_name.to_upper(), gained_experience])
	print("EXPERIENCE GAINED: ", gained_experience)

	Player.current_EXP = min (Player.max_EXP, Player.current_EXP + gained_experience)
	if(Player.current_EXP == Player.max_EXP):
		var stats_update = Player.level_up()
		player_level_label.text = "Lv. %s" % Player.level		
		display_text("%s stats updated to %s " % [Player.creature_name, stats_update])


func show_player():
	playerPanel.show()
	player_turn = true
	set_health(player_hp_progress, Player.current_health, Player.max_health)

func show_enemy():
	enemyPanel.show()
	set_health(enemy_hp_progress, current_creature.current_health, current_creature.health)
	intro_text("%s challenges you to a battle" % [Quest.challenger_name])

func set_health(progress_bar, health, max_health):
	Creature.update_creature = true
	progress_bar.value = health;
	progress_bar.max_value = max_health;
	progress_bar.get_node("../../../MarginContainer/VBoxContainer/Health").text = "HP:%d/%d" % [health, max_health]

func _input(_event):
	if player_turn and ((Input.is_action_just_pressed("ui_accept") or Input.is_mouse_button_pressed(BUTTON_LEFT)) and text_box.visible) :
		text_box.hide()
		actionPanel.show()

func enemy_turn():
	# randomise the attack todo
	var opponent_chosen_attack = Quest.choose_random_attack(current_creature)
	var damage_dealth = opponent_chosen_attack.damage * current_creature.damage
	print("OPPONENTE USED: ", opponent_chosen_attack)

	player.get_node("Help").visible = false
	display_text("The wild %s used %s" % [current_creature.creature_name.to_upper(), opponent_chosen_attack.name.to_upper()])

	Player.current_health = max(0, Player.current_health - damage_dealth)
	set_health(player_hp_progress, Player.current_health, Player.max_health)

	$InterpolatedCamera/PartnerCamera.play("shake")
	display_text("The wild %s used %s and dealth %s damage!" % [current_creature.creature_name.to_upper(), opponent_chosen_attack.name.to_upper(),  damage_dealth])

	yield($InterpolatedCamera/PartnerCamera, "animation_finished")

	if Player.current_health == 0:
		choose_creature_or_run()
	else:
		player_turn = true
		actionPanel.show()

	update_creature_stats()

func choose_creature_or_run():
	display_text("Oh no xD.. %s can't go on any longer.." % [player_partner.nickname])
	update_creature_stats()
	
	if Creature.can_team_continue():
		var _not_in_use = get_tree().create_timer(textbox_cooldown).connect("timeout", self, "_next")
		display_text("Go to your bag and select a creature, or RUN!")
		swapping_on()
	else:
		loose_battle()
	
func swapping_on ():
	player_turn = true
	disable_creature_buttons()
	actionPanel.show()
	Creature.select_during_battle_on = true
	waiting = true
		
func loose_battle():
	Player.lose = true
	var _not_in_use = get_tree().create_timer(textbox_cooldown).connect("timeout", self, "changeSceneTo")

func disable_creature_buttons ():
	attack1_button.disabled = true
	attack2_button.disabled = true
	heal_button.disabled = true
	catch_button.disabled = true
	
func continue_battle ():
	attack1_button.disabled = false
	attack2_button.disabled = false
	heal_button.disabled = false
	catch_button.disabled = false
	
	update_creature_stats()	
	swap_creature(Creature.battle_creature_selected_position)
	
	waiting = false
	Creature.select_during_battle_on = null
	Creature.battle_creature_selected_position = null
	
func _on_Run_pressed():
	waiting = false
		
	if player_turn:
		display_text("YOu Cannot RUn from MEEEEE heheh xD")
		
func _on_Heal_pressed():
	actionPanel.hide();
	if player_turn:
		player_turn = false
		display_text("%s is on defence! HP recovered by %d" % [player_partner.nickname.to_upper(), Player.defence])
		Player.current_health = min(Player.max_health, Player.current_health + Player.defence)

		set_health(player_hp_progress, Player.current_health, Player.max_health)

		display_text("You regained %s health!" % [Player.defence])
#		swap_creature(0)

		actionPanel.hide()
		var _not_in_use = get_tree().create_timer(textbox_cooldown).connect("timeout", self, "enemy_turn")

func _next() :
	pass

func changeSceneTo() :
	Player.at_battle = false
	
	Creature.select_during_battle_on = null
	Creature.battle_creature_selected_position = null
	
	
	
	if not (Player.lose):
		print("WIN: ", Player.lose)
		print("Global.current_level_name: ",Global.current_level_name)

		update_creature_stats()
		Global.current_scene_name = Global.current_level_name
		Global.disconnect_player()
		Quest.battle_player_wins = true
		var _not_in_use = get_tree().change_scene(out_of_battle)		
	else:
		print("you lose: heres the SIGNSAVE path => ", Global.LevelPathway_SignSave)
		update_creature_stats()
		# go to previous saved position
		# for now jsut reload in the same scene but no saved position
		if(Global.LevelPathway_SignSave != null):
			Global.current_scene_name = Global.LevelName_SignSave	
			var _not_in_use = get_tree().change_scene(Global.LevelPathway_SignSave)	
			Global.disconnect_player()

		else:
			Global.from_Grass = null
			Global.current_scene_name = Global.current_level_name		
			Global.disconnect_player()
			var _not_in_use = get_tree().change_scene(out_of_battle)	

func intro_text (text):
	text_box.get_node("Panel/Box/label").text = text
	text_box.show()	
	emit_signal("dialogue_closed")
	yield(self, "dialogue_closed")	
	text_box.hide()

func display_text (text):
	text_box.get_node("Panel/Box/label").text = text
	timerYield(textbox_cooldown)

	text_box.show()
func timerYield(cooldown):
	var _not_in_use = get_tree().create_timer(cooldown).connect("timeout", self, "textBoxHideAfterTimer")

func textBoxHideAfterTimer():
#	print("textbox show")	
	text_box.hide()

func update_creature_stats ():
	# some stats doesn changed unles level up or given golden apple
	player_partner.damage = Player.damage
	player_partner.experience = Player.max_EXP	
	player_partner.current_experience = Player.current_EXP 
	player_partner.level = Player.level
	player_partner.defence = Player.defence
	player_partner.health = Player.max_health
	player_partner.current_health = Player.current_health

	Player.creaventory.player_creature_info_changed(creature_position, player_partner)

	player_level_label.text = "Lv. %s" % Player.level
	player_name_label.text = player_partner.nickname
	set_health(player_hp_progress, Player.current_health, Player.max_health)


func partner_attacks_with(attack_info):
	display_text(attack_info.description)

	current_creature.current_health = max(0, current_creature.current_health - attack_info.damage*Player.damage)
	set_health(enemy_hp_progress, current_creature.current_health, current_creature.health)
#		print("health: ", current_enemy_health)
	$AnimationPlayer.play("enemy_damaged")
	yield($AnimationPlayer, "animation_finished")

	display_text("%s dealt %d damage!" % [Player.creature_name.to_upper(), attack_info.damage*Player.damage])

#	$InterpolatedCamera/PartnerCamera.play("shake")

	if current_creature.current_health == 0:
		display_text("The wild %s fainted xD.." % [current_creature.creature_name.to_upper()])

		gain_experience_from_fight()
		update_creature_experience_progress()
		Global.set_progress_bar(player_dizziness_progress, Player.current_dizziness, Player.max_dizziness)
		
		opponent_chooses_next_creature()
		
	else:
		enemy_turn()

func _on_Attack1_pressed():
	actionPanel.hide()
	var attack_pos = 0
	if player_turn:
		player_turn = false
		partner_attacks_with(Player.available_attacks[attack_pos])


func _on_Attack2_pressed():
	actionPanel.hide()
	var attack_pos = 1

	print("DEALTH DAMAGE: ", Player.damage)

	if player_turn:
		player_turn = false
		partner_attacks_with(Player.available_attacks[attack_pos])


func _on_Catch_pressed():
	print("catch")
	# catch rate if worked out
	if (Player.current_dizziness >= 10):
		display_text("Hah you can't tame someone else's creature")
	else:
		display_text("You're too dizzy to concentrate!")
	pass # Replace with function body.


func _on_Swap_pressed():
	swapping_on()

func opponent_chooses_next_creature():
	current_creature = Quest.challenger_next_creature()
	print("current_creature: OUCH ", Quest.challenger_team_position)
	if not Quest.challenger_lose : 
		ready_enemy_creature_sprite()
		enemy_turn()	
	else:
		Quest.challenger_lose = false
		print("current_creature: OUCH HEHEHEHEH ", Quest.challenger_lose)
		
		display_text(".... ...aa")
		
		
		
		var _not_in_use = get_tree().create_timer(textbox_cooldown + 1).connect("timeout", self, "changeSceneTo")
		
