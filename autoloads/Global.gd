extends Node


onready var utilities = Utilities.new()
onready var root = get_tree().root

var menu_opened = false

var player_town_idx := 0
var player_towns_unlocked := 1

var initialized = false

var preload_dict = {}
var character_dict = {
	"Alpha": {
		"data" : preload("res://resources/characters/Alpha.tres"), 
		"recruitable": true,
		"active": false
		}, 
	"Beta": {
		"data": preload("res://resources/characters/Beta.tres"),
		"recruitable": true,
		"active": false
		} 
}
var player_dict = {
	"player_name" : "Steebo", 
	"current_party": ["Beta"],
	"available_pary": ["Alpha"],
	"known_convictions" : {}
}

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
	EventBus.connect("conviction_learned", self,"learn_conviction")
	print("Global Ready")
	pass # Replace with function body.

func start_game():
	print("Global starting game")
	initialize_player()
	initialized = true
	SceneManager.change_scene("res://Scenes/Cutscenes/Intro_1.tscn")
	

func initialize_player():
	if !initialized:
		character_dict[player_dict.player_name] = {
			"data": preload("res://resources/characters/player.tres"),
			"recruitable": true,
			"active": true
		}
		character_dict[player_dict.player_name].data.character_name = player_dict.player_name
		player_dict["current_party"].append(player_dict.player_name)
		initialized = true

func _on_quit_requested():
	AudioManager.play_music("Theme1")
	SceneManager.change_scene("res://Scenes/StartScreen/StartScreen.tscn")


func learn_conviction(conviction : Conviction):
	print("Attempting to learn conviction %s" % conviction.conviction_name)
	if !player_dict.known_convictions.has(conviction.conviction_name):
		var conviction_data = {
				"name": conviction.conviction_name, 
				"level": 1, 
				"xp": 0, 
			}
		var known_conviction = KnownConviction.new(conviction_data)
		player_dict.known_convictions[conviction.conviction_name] = known_conviction
		print("Conviction learned %s" % known_conviction.conviction.conviction_name)
		EventBus.emit_signal("conviction_updated")
	else:
		print("Conviction %s already known" % conviction.conviction_name)
