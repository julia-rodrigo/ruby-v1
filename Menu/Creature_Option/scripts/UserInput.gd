extends LineEdit

# to do with the renaming button

func _ready():
	grab_focus()
	set_cursor_position(len(text))

