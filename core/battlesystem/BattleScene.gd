extends Node2D
class_name BattleScene

onready var gameboard = $Gameboard
onready var battlegrid = $BattleMap

export (Array, Resource) var units = []

func _ready():
	if !Global.initialized:
		Global.initialize_player()
	for member in Global.player_dict.current_party:
		units.append(Global.character_dict[member])
	gameboard.set_grid(battlegrid)
	gameboard.initialize(units)
	EventBus.emit_signal("battle_scene_ready", battlegrid)
	EventBus.connect("battle_end", self, "_on_battle_end")
	print("Battlescene ready.")
	pass # Replace with function body.

func _on_battle_end(victory : bool):
	if victory:
		print("Battle End: Victory")
	else:
		print("Battle End: Failure")
	SceneManager.change_scene("res://scenes/WorldMap.tscn")
