extends Node
class_name KnownConviction

export (Resource) var conviction setget set_conviction
export (int) var level setget set_level
export (int) var experience setget set_experience

func set_conviction(value: Conviction):
	conviction = value
	
func set_level(value : int):
	level = value
	
func set_experience(value: int):
	experience = value
