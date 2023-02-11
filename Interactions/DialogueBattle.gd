extends CanvasLayer

export var dialogPath = "res://import/Dialogue/json/battle.json"
export (float) var textSpeed = 0.05

var dialog

var phraseNum = 0
var textReveal = 0;
var finished = false

signal dialogue_closed
 

func _ready():
	$Timer.wait_time = textSpeed
	dialog = getDialog()
	assert (dialog, "Dialog not found")
	nextPhrase()

func _input (event):
	if event.is_action_pressed("dialogue_next"):
		nextPhrase()

func play():
	phraseNum = -1
	nextPhrase()
		
func _process(_delta):
	print("finished: ", finished)
	if Input.is_action_just_pressed("ui_accept"):
		if finished:
			nextPhrase()
		else: 
			$NinePatchRect/Message.visible_characters = len($NinePatchRect/Message.text)

func getDialog() -> Array:
	var f = File.new()
	assert(f.file_exists(dialogPath), "File path does not exist")

	f.open(dialogPath, File.READ)
	var json = f.get_as_text()
	
	var output = parse_json(json)
	
	if typeof(output) == TYPE_ARRAY:
		return output
	else: 
		return []
		
func nextPhrase() -> void:
	if phraseNum >= len(dialog):
		queue_free()
		emit_signal("dialogue_closed")
		print("done")
		$NinePatchRect.hide()
		yield(self, "dialogue_closed")
		return 
		
	finished = false
	
	$NinePatchRect/Name.text = dialog[phraseNum]["name"]
	$NinePatchRect/Message.text = dialog[phraseNum]["message"]
	
	$NinePatchRect/Message.visible_characters = 0
	
	print(finished)
	
	while $NinePatchRect/Message.visible_characters < len($NinePatchRect/Message.text):
		$NinePatchRect/Message.visible_characters += 1
		
		$Timer.start()
		yield($Timer, "timeout")
	
	finished = true
	phraseNum += 1
	return 
		
	
	
