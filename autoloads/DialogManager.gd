extends Node


func conviction_learned(conviction):
	print("Conviction learned in dialog signaling: %s" % conviction)
	EventBus.emit_signal("conviction_learned", Global.conviction_dictionary[conviction])
	
	
func dialog_ended():
	EventBus.emit_signal("cutscene_ended", Dialogic.get_variable("experience_gain") as int, Dialogic.get_variable("strength") as bool, Dialogic.get_variable("peace") as bool)
	Dialogic.clear_all_variables()	
	print("Dialog variables cleared. New: Experience: %d Strength %s Peace %s" % [Dialogic.get_variable("experience_gain") as int, Dialogic.get_variable("strength") as bool, Dialogic.get_variable("peace") as bool])
	SceneManager.change_scene("res://scenes/BattleScenes/BattleScene_1.tscn")
