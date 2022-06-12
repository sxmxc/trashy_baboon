extends Resource
class_name Conviction

export(String) var conviction_name setget _set_name
export(String) var conviction_description setget _set_description
export(Texture) var conviction_icon setget _set_icon
export(Resource) var conviction_battle_ability setget _set_battle_ability


func _set_battle_ability(ability: BattleAbility):
	conviction_battle_ability = ability

func _set_icon(icon: Texture):
	conviction_icon = icon

func _set_description(text: String):
	conviction_description = text

func _set_name(text: String):
	conviction_name = text
