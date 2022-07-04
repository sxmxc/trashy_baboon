extends Node2D
class_name BattleScene

onready var gameboard = $Gameboard as GameBoard
onready var battlegrid = $BattleMap

export (Array, Resource) var units = []
export (Array, Resource) var enemies = []

func _ready():
	if !CharacterManager.initialized:
		CharacterManager.initialize_player()
	for member in CharacterManager.player_dict.current_party:
		units.append(CharacterManager.character_dict[member])
	for enemy in enemies:
		units.append(CharacterManager.character_dict[enemy.character_name])
	gameboard.set_grid(battlegrid)
	print("BS(base): Battlescene parent loading data.")
	gameboard.load_data(units)
	EventBus.emit_signal("battle_scene_ready", battlegrid)
	EventBus.connect("battle_end", self, "_on_battle_end")
	print("BS(base): Battlescene parent ready.")
	pass # Replace with function body.

func intialize(enemies_array):
	enemies = enemies_array
	

func _on_battle_end(victory : bool):
	if victory:
		print("BS(base): Battle End: Victory")
	else:
		print("BS(base): Battle End: Failure")
	SceneManager.change_scene("res://scenes/WorldMap.tscn")
