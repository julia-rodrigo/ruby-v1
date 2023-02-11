extends CanvasLayer

export(String, FILE, "*.json") var dialogue_file

var dialogues = []
func _ready():
	play()
	
func play():
	dialogues = load_dialogue()
	
	$NinePatchRect/Name.text = dialogues[0]['name']
	$NinePatchRect/Message.text = dialogues[2]['message']
	
func load_dialogue():
	var file = File.new()
	if file.File_exists(dialogue_file):
		file.open(dialogue_file, file.READ)
		return parse_json(file.get_as_text())

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
