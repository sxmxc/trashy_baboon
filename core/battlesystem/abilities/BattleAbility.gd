extends Resource
class_name BattleAbility

export(String) var ability_name setget _set_name
export(String) var ability_description setget _set_description
export(Texture) var ability_icon setget _set_icon



func _set_icon(icon: Texture):
	ability_icon = icon

func _set_description(text: String):
	ability_description = text

func _set_name(text: String):
	ability_name = text
