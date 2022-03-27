extends Node
class_name Character

onready var stats =  $Stats
onready var convictions = $Convictions

enum CONTROL { PLAYER, AI }

export (Resource) var starting_stats

export (String) var character_name setget set_character_name
export (CONTROL) var control_type

# Called when the node enters the scene tree for the first time.
func _ready():
	stats.initialize(starting_stats)
	convictions.initialize(starting_stats)
	pass # Replace with function body.
	
func intialize():
	Global.register_character(self)

func set_character_name(value):
	character_name = value

func get_character_name():
	return character_name
