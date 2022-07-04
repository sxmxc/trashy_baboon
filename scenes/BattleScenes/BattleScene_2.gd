extends BattleScene

# Called when the node enters the scene tree for the first time.
func _ready():
	var dialog = Dialogic.start("beta_1")
	dialog.connect("timeline_end", self, "_on_cutscene_finish")
	dialog.pause_mode = PAUSE_MODE_PROCESS
	add_child(dialog)
	print("BS(child): Battlescene descendent ready")
	get_tree().paused = true
	pass # Replace with function body.
	
	
func _on_cutscene_finish(_arg):
	get_tree().paused = false
	pass


func _on_battle_end(victory : bool):
	if victory:
		print("BS(child): Battle End: Victory")
		Dialogic.set_variable('character_joined', "Beta")
		CharacterManager.add_to_roster("Beta")
		var dialog = Dialogic.start("summary")
		dialog.pause_mode = PAUSE_MODE_PROCESS
		add_child(dialog)
		get_tree().paused = true
		yield(dialog,"timeline_end")
		get_tree().paused = false
		Global.go_to_worldmap()
	else:
		print("BS(child): Battle End: Failure")
		Global.go_to_main_menu()
	
