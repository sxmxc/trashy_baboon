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


func equip_conviction(conviction: Conviction):
	if !Global.player_dict.known_convictions.has(conviction.conviction_name):
		Global.learn_conviction(conviction)
	if !equipped_convictions.has(conviction.conviction_name) and !(equipped_convictions.size() >= max_equipped_convictions):
		equipped_convictions.append(conviction.conviction_name)
		EventBus.emit_signal("conviction_equipped")



