extends Node2D

onready var gameboard = $Gameboard
onready var battlegrid = $BattleMap

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	gameboard.set_grid(battlegrid)
	pass # Replace with function body.



