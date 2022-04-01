extends TownMap


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func _ready():
#	Dialogic.set_variable('player_name', Global.player_dict.player_name)
#	var dialog = Dialogic.start("intro_2")
#	dialog_ui.add_child(dialog)
	tile_map.set_player(player)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
