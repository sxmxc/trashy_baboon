extends Node


onready var utilities = Utilities.new()
onready var root = get_tree().root

var menu_opened = false

var player_town_idx := 0
var player_towns_unlocked := 1

var preload_dict = {}

var conviction_dictionary = {
	"Strength" : preload("res://resources/convictions/strength.tres"), 
	"Peace" : preload("res://resources/convictions/peace.tres"),
	"Courage": preload("res://resources/convictions/courage.tres"), 
	"Survival" : preload("res://resources/convictions/survival.tres")
}

var town_dict = {
	0 : "res://scenes/Towns/Town0/town_0.tscn", 
	1 : "res://scenes/Towns/Town1/town_1.tscn",
	2 : "res://scenes/Towns/Town1/town_1.tscn",
	3 : "res://scenes/Towns/Town1/town_1.tscn",
	4 : "res://scenes/Towns/Town1/town_1.tscn",
	5 : "res://scenes/Towns/Town1/town_1.tscn",
	6 : "res://scenes/Towns/Town1/town_1.tscn",
	7 : "res://scenes/Towns/Town1/town_1.tscn",
	8 : "res://scenes/Towns/Town1/town_1.tscn",
	9 : "res://scenes/Towns/Town1/town_1.tscn",
	10 : "res://scenes/Towns/Town1/town_1.tscn"
}

var hidden_towns = {
	"Hidden Village" : {
		"index": 2, 
		"unlocked": false
	},
	"Hidden Caves" : {
		"index": 3, 
		"unlocked": false
	}
}

# Called when the node enters the scene tree for the first time.
func _ready():
	EventBus.connect("quit_requested",self, "_on_quit_requested")
	print("GLOBAL: Global Ready")
	pass # Replace with function body.

func start_game():
	print("GLOBAL: Global starting game")
	CharacterManager.initialize_player()
	SceneManager.change_scene("res://scenes/Cutscenes/Intro_1.tscn")
	

func _on_quit_requested():
	AudioManager.play_music("Theme1")
	SceneManager.change_scene("res://scenes/StartScreen/StartScreen.tscn")

func go_to_main_menu():
	SceneManager.change_scene("res://scenes/StartScreen/StartScreen.tscn")
	
func go_to_worldmap():
	SceneManager.change_scene("res://scenes/WorldMap.tscn")

