extends GridContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func initialize():
	for member in CharacterManager.player_dict["available_party"]:
		var badge = load("res://scenes/UI/PartyMemberBadge.tscn").instance()
		add_child(badge)
		badge.set_data(CharacterManager.character_dict[member].data)
		
