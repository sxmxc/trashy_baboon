extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	AudioManager.stop_music()
	AudioManager.stop_efx()
	AudioManager.play_music("DialogTheme")
	Dialogic.set_variable('player_name', CharacterManager.player_dict.player_name)
	var dialog = Dialogic.start("intro_1")
	add_child(dialog)
	pass # Replace with function body.
	

