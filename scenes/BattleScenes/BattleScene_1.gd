extends BattleScene

# Called when the node enters the scene tree for the first time.
func _ready():
	var dialog = Dialogic.start("battle_tutorial_1")
	dialog.connect("timeline_end", self, "_on_cutscene_finish")
	dialog.pause_mode = PAUSE_MODE_PROCESS
	add_child(dialog)
	get_tree().paused = true
	pass # Replace with function body.
	
	
func _on_cutscene_finish(_arg):
	get_tree().paused = false
	pass
