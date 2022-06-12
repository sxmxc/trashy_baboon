extends Node2D

onready var gameboard = $Gameboard
onready var battlegrid = $BattleMap

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	gameboard.set_grid(battlegrid)
	var dialog = Dialogic.start("battle_tutorial_1")
	dialog.connect("timeline_end", self, "_on_cutscene_finish")
	dialog.pause_mode = PAUSE_MODE_PROCESS
	add_child(dialog)
	get_tree().paused = true
	pass # Replace with function body.


func _on_cutscene_finish(arg):
	get_tree().paused = false
	pass
