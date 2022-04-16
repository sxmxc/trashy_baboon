extends Node
class_name WorldMember

export(Resource) var character

signal initialized(party_member)

export (String) var display_name
export (int) var hp
export (int) var mp
export (int) var max_hp
export (int) var max_mp
export (int) var mgk_atk
export (int) var mgk_def
export (int) var speed

export (Dictionary) var convictions

var member_sprite

func _ready():
	pass # Replace with function body.

func initialize(base_char: Character):
	character = base_char
	max_hp = character.base_stats.starting_hp
	max_mp = character.base_stats.starting_mp
	hp = max_hp
	mp = max_mp
	mgk_atk = character.base_stats.starting_mgatk
	mgk_def = character.base_stats.starting_mgdef
	speed = character.base_stats.starting_speed
	display_name = character.name if character.name != "" else "Unknown"
	member_sprite = character.char_sprite
	for conv in character.base_stats.starting_convictions:
		convictions[conv.name] = {"level" : 0, "xp": 0, "equipped": true}
	emit_signal("initialized", self)
	pass
	
func get_conviction_experience(conviction_name) -> int :
	if convictions.has(conviction_name):
		return convictions[conviction_name].xp
	return 0
	
func add_conviction_experience(conviction_name, amount):
	if convictions.has(conviction_name):
		if convictions[conviction_name].equipped:
			convictions[conviction_name].xp += amount
			EventBus.emit_signal("conviction_xp_gained", conviction_name, amount)
			
func get_conviction_level(conviction_name) -> int :
	if convictions.has(conviction_name):
		return convictions[conviction_name].level
	return 0

