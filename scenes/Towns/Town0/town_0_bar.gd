extends Node2D


signal cutscene_end

# Called when the node enters the scene tree for the first time.
func _ready():
	Dialogic.set_variable('player_name', CharacterManager.player_dict.player_name)
	var dialog = Dialogic.start("town_0_bar_0")
	dialog.connect("timeline_end", self, "on_cutscene_finish")
	add_child(dialog)
	pass # Replace with function body.

func on_cutscene_finish(arg):
	emit_signal("cutscene_end",arg)
