extends Resource
class_name Conviction

export var name : String
export var description : String
export var philosophy : Resource
export var level_to_philosophy : int
export var current_level : int
export var experience : int
export var experience_to_next_level : int
export var philosopy_unlocked : bool

func apply_experience(value):
	experience += value
	if experience >= experience_to_next_level:
		level_up()


func level_up():
	current_level += 1
	experience_to_next_level += experience_to_next_level * .25
	pass		
