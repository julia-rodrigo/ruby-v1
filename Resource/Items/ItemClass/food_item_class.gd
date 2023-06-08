tool
extends Item

class_name foodItem

# treasured snack

export (int) var health_restore
export (int) var level_up
export (int) var stats_increase

export (int) var damage
export (int) var defence
export (int) var health
export (int) var experience
export (int) var dizziness_recovery

func food_eaten ():
	return {
		"current_health": health_restore,
		"level": level_up,
		# stats increases
		"damage": damage,
		"defence": defence,
		"health": health,
		"current_experience": experience
	}


#return [
#		{"current_health": health_restore},
#		{"level": level_up},
#		# stats increases
#		{"damage": damage},
#		{"defence": defence},
#		{"health": health},
#		{"current_experience": experience}
#	]
func get_dizziness_recovery ():
	return dizziness_recovery


#[
#		{ "name":  "Claw", "damage": 2 , "description": "A basic attack most monsters know!", "chance": 20 },
#		{ "name":  "CapHat", "damage": 5, "description": "Thats a Feet Special!", "chance": 5  },
#		{ "name":  "Bella", "damage": 4, "description": "Thats a Tihi Special!", "chance": 5  },
#		{ "name":  "Sniff", "damage": 2, "description": "Hey!", "chance": 20  },
#		{ "name":  "Paw", "damage": 1, "description": "soft feet", "chance": 20  },
#		{ "name":  "Hide", "damage": 3, "description": "Searching.... !", "chance": 10  },
#		{ "name":  "Aero", "damage": 3, "description": "Thats a Hasven Special!", "chance": 5  },
#		{ "name":  "Top Star :D", "damage": 100000, "description": "This is Tendo Maya!", "chance": 1  }
#	]


