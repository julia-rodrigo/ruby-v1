extends Spatial

export (Resource) var enemy = null

var current_player_health = 0
var current_enemy_health = 0

signal dialogue_closed

var player_turn = false

func _ready():
	$TextBox.hide()
	$ActionPanel.hide()
	$PlayerPanel.hide()
	$EnemyContainer.hide()
	
	print ("dialogue_closed_%s" % $Spawner/DialogueTest/DialogueBattle/NinePatchRect.visible)
	yield (get_node("Spawner/DialogueTest/DialogueBattle"), "dialogue_closed") # the object that holds the scripte, the signal wanted
	yield(get_tree().create_timer(0.5), "timeout")
	
	current_player_health = State.current_health
	current_enemy_health = enemy.health
	
	player_turn = true
	show_player()
	show_enemy()
	
	
func show_player():
	$PlayerPanel.show()
	set_health($PlayerPanel/PlayerData/ProgressBar, State.current_health, State.max_health)
	$PlayerPanel/Partner/KinematicBody.get_node("%sIdel" % ["Tihi"]).show()
	$PlayerPanel/Partner/KinematicBody/AnimationPlayer.play("%s_Idel" % ["Tihi"])
	
func show_enemy():
	print("enemy data: ", enemy.name)
	$EnemyContainer/Enemy/KinematicBody.get_node("%sIdel" % [enemy.name]).show()
	$EnemyContainer/Enemy/KinematicBody/AnimationPlayer.play("%s_Idel" % [enemy.name])
	$EnemyContainer.show()
	set_health($EnemyContainer/ProgressBar, enemy.health, enemy.health)
	display_text("A wild %s appeared!!" % [enemy.name.to_upper()])
	
func set_health(progress_bar, health, max_health):
	progress_bar.value = health;
	progress_bar.max_value = max_health;
	progress_bar.get_node("Label").text = "HP:%d/%d" % [health, max_health]

func _input(event):
	if player_turn and ((Input.is_action_just_pressed("ui_accept") or Input.is_mouse_button_pressed(BUTTON_LEFT)) and $TextBox.visible) :
		$ActionPanel.show()
		yield(get_tree().create_timer(0.2), "timeout")
		$TextBox.hide()
	
func display_text (text):
	$TextBox.show()
	$TextBox/Label.text = text

func enemy_turn() :
	print("here")
	display_text("The opponent's %s insulted you with the same energy" % [enemy.name.to_upper()])
	yield(get_tree().create_timer(0.9), "timeout")
	$TextBox.hide();
	
	current_player_health = max(0, current_player_health - enemy.damage)
	set_health($PlayerPanel/PlayerData/ProgressBar, current_player_health, State.max_health)
	print("health: ", current_player_health)
	
	$InterpolatedCamera/PartnerCamera.play("shake")
	yield($InterpolatedCamera/PartnerCamera, "animation_finished")
	
	display_text("Opponent's %s dealth %s damage!" % [enemy.name.to_upper(), enemy.damage] )
	yield(get_tree().create_timer(0.9), "timeout")
	$TextBox.hide();
	
	
	if current_player_health == 0:
		display_text("Oh no xD.. %s can't go on any longer.." % ["TIHI"])
		yield(get_tree().create_timer(0.9), "timeout")
		$TextBox.hide()
		yield(get_tree().create_timer(0.5), "timeout")
		get_tree().change_scene("res://World.tscn");
		
	player_turn = true
	$ActionPanel.show()
	
	
func _on_Run_pressed():
	$ActionPanel.hide();
	if player_turn:
		player_turn = false
		
		display_text("Got away safely!");
		yield(get_tree().create_timer(0.85), "timeout")
		get_tree().change_scene("res://World.tscn");

func _on_Attack_pressed():
	$ActionPanel.hide()
	if player_turn:
		player_turn = false
		yield(get_tree().create_timer(0.2), "timeout")
		display_text("Ruby: yeh mates belonge in d'strets!!!")
		yield(get_tree().create_timer(0.9), "timeout")
	#	display_text("Tihi: yeheheheeheh xD")
	#	yield(get_tree().create_timer(0.2), "timeout")
		$TextBox.hide();
		
		current_enemy_health = max(0, current_enemy_health - State.damage)
		set_health($EnemyContainer/ProgressBar, current_enemy_health, enemy.health)
		print("health: ", current_enemy_health)
		$AnimationPlayer.play("enemy_damaged")
		yield($AnimationPlayer, "animation_finished")
		
		display_text("You dealt %s damage!" % [State.damage] )
		yield(get_tree().create_timer(0.9), "timeout")
		$TextBox.hide();
		
	#	$InterpolatedCamera/PartnerCamera.play("shake")
		
		
		if current_enemy_health == 0:
			display_text("The opponent's %s fainted xD.." % [enemy.name.to_upper()])
			yield(get_tree().create_timer(0.9), "timeout")
			$TextBox.hide()
			yield(get_tree().create_timer(0.5), "timeout")
			
			get_tree().change_scene("res://World.tscn");
		
		enemy_turn()


func _on_Heal_pressed():
	$ActionPanel.hide();
	if player_turn:
		player_turn = false
		display_text("Ruby: heres some apples mate")
		yield(get_tree().create_timer(0.9), "timeout")
	#	display_text("Tihi: yeheheheeheh xD")
	#	yield(get_tree().create_timer(0.2), "timeout")
		$TextBox.hide();
		
		current_player_health = min(State.max_health, current_player_health + 30)
		set_health($PlayerPanel/PlayerData/ProgressBar, current_player_health, State.max_health)
		
	#	$AnimationPlayer.play("player_heals")
		
		display_text("You regained %s health!" % [30] )
		yield(get_tree().create_timer(0.9), "timeout")
		$TextBox.hide();
		
	#	$InterpolatedCamera/PartnerCamera.play("shake")
		$ActionPanel.hide()
		enemy_turn()
