extends Resource
class_name CharacterData

export (String) var character_name

export var base_health_max := 100
export var base_speed := 100
export var base_range := 6
export var base_action_points := 2
export var max_equipped_convictions := 5
export (Texture) var char_sprite
export (Texture) var char_portrait
export (Array, String) var equipped_convictions

export (Array) var dialog_timelines

func get_equipped_convictions() -> Array:
	return equipped_convictions



