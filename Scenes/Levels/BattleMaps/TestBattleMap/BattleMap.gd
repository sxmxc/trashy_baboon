extends Node2D
class_name BattleMap

onready var tile_map = $TileMap
onready var battle_ui = $BattleUI
onready var dialog_ui = $DialogUI

var player

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	if !player:
		player = $TileMap/YSort/Player
	yield(EventBus, "map_changed")
	print("Map changed signal received by BattleMap")
	tile_map.set_player(player)
	EventBus.connect("transition_end", self, "_on_transition_end")

func _on_transition_end():
	var dialog = Dialogic.start("battle_tutorial_1")
	#dialog.connect("timeline_end", self, "on_cutscene_finish")
	add_child(dialog)
	pass
