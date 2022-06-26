extends Node2D
class_name BattleScene

onready var gameboard = $Gameboard
onready var battlegrid = $BattleMap

export (Array, Resource) var units = []

func _ready():
	gameboard.set_grid(battlegrid)
	gameboard.initialize(units)
	pass # Replace with function body.
