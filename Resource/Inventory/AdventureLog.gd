extends Resource
class_name AdventureLog

signal adventure_log_changed
export var _adventures = Array () setget set_adventures, get_adventures

func set_adventures (new_adventures):
	_adventures = new_adventures
	
	var current_adventure = _adventures[_adventures.size() - 1]
	if current_adventure.completed:
		Quest.CURRENT_QUEST_ID = (current_adventure.quest_id + 1)
	else:
		Quest.CURRENT_QUEST_ID = current_adventure.quest_id
	
	Quest.current_quest = current_adventure
	
#	print("Ongoing quest: id -> ", Quest.CURRENT_QUEST_ID)
#	print("Ongoing quest: name -> ", Quest.current_quest.name)
	
	emit_signal ("adventure_log_changed", self)

func get_adventures ():
	return _adventures

func get_adventure (index): # single creature
	return _adventures [index]
	
func get_adventure_by_name (adventure_name):
	for adventure in _adventures :
		if adventure_name == adventure.name:
			return (adventure)
			
	print("no adventure of that name found in your adventure logs")
	
func add_adventure (adventure_name): # add single creature
	
	
	var adventure = AdventureDatabase.get_adventure(adventure_name)
	if not adventure:
		print ("could not find adventure Adventory.gd: ", adventure_name)
		return
	
	if adventure.quest_id != Quest.CURRENT_QUEST_ID:
		print("the quest id is not updated yet so we cannot add this quest: %d -> %d " % [Quest.CURRENT_QUEST_ID, adventure.quest_id])
		return
		
	var new_adventure = save_adventure_progress(adventure)
	_adventures.append (new_adventure)
	
#	Quest.current_quest = new_adventure
	print("Quest.CURRENT_QUEST_ID updated to: ", Quest.current_quest.name)
				
	print("ADDED ADVENTURE: ", new_adventure.name)
		
	emit_signal("adventure_log_changed", self) # Player.inventory

func add_adventure_found (adventure_resource): # add single creature
	
	var adventure = AdventureDatabase.get_adventure(adventure_resource.name)
	if not adventure:
		print ("could not find adventure AdventureLog.gd: ", adventure_resource.name)
		return
	
	adventure = adventure_resource
	var new_adventure = save_adventure_progress(adventure)
	
	_adventures.append (new_adventure)
	
#	Quest.current_quest = new_adventure
	
	emit_signal("adventure_log_changed", self) # Player.inventory

func save_adventure_progress (adventure):
	var additional_quest_info = adventure.get_additional_quest_info()
	var quest_info_title = additional_quest_info.keys()
	var quest_info_descriptions = additional_quest_info.values()
	
	var full_info = { adventure_reference = adventure }
	
	for i in additional_quest_info.size():
		full_info.merge({ 
			quest_info_title[i] : quest_info_descriptions[i]
		})
		
#	print("full info, ", full_info)
	Quest.current_quest = full_info
	return full_info
	
func player_adventure_info_changed (position, adventure): # position and the creature itself
	_adventures[position] = save_adventure_progress(adventure)
	emit_signal("adventure_log_changed", self) 
	




