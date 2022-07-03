extends Resource
class_name KnownConviction

export var conviction: Resource
export var conviction_level: int
export var conviction_xp: int


func _init(data):
	conviction = Global.conviction_dictionary[data.name] as Conviction
	conviction_level = data.level
	conviction_xp = data.xp
