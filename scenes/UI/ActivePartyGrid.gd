extends GridContainer


var badge_scene = preload("res://scenes/UI/PartyMemberBadge.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func initialize():
	print("UI: ActivePartyGrid container initializing")
	if !CharacterManager.initialized:
		CharacterManager.initialize_player()
	for member in CharacterManager.player_dict["current_party"]:
		var badge = badge_scene.instance()
		add_child(badge)
		badge.set_data(CharacterManager.character_dict[member].data)
		
