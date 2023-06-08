extends Panel

onready var item_details_info_label = $outerMargin/innerVbox/TopHbox/Description/info
onready var money_amount_label = $outerMargin/innerVbox/TopHbox/MoneyContainer/margin/money
onready var player_dizziness_label = $outerMargin/innerVbox/ContentMargin/SeparateMargin/PlayerDizziness/Label
onready var player_dizziness_progress = $outerMargin/innerVbox/ContentMargin/SeparateMargin/PlayerDizziness/DizzinessBar

# this is updating the player dizziness in the bag section [A]
	
func _process(_delta):
	if Player.creature_caught != null:
		Player.creature_caught = null
		update_dizziness_progress_bar()
		return
		
	if Player.recover_from_dizziness != null:
		Player.recover_from_dizziness = null
		Player.current_dizziness = min (Player.max_dizziness, Player.current_dizziness + Player.recovery_dizziness_item.item_reference.get_dizziness_recovery())
		update_dizziness_progress_bar()
		return
	
func _on_BagPanel_visibility_changed():
	update_dizziness_progress_bar()

func update_dizziness_progress_bar ():
	Global.set_progress_bar(player_dizziness_progress, Player.current_dizziness, Player.max_dizziness)
	Global.set_progress_bar_label (player_dizziness_label, Player.current_dizziness, Player.max_dizziness, "Dizziness")
