extends Node


onready var _music_player = $MusicPlayer as AudioStreamPlayer2D
onready var _sfx_player = $SfxPlayer as AudioStreamPlayer2D
onready var utilities = $Utils
onready var root = get_tree().root

var menu_opened = false

var player_town_idx := 0
var player_towns_unlocked := 1

export var audio_dict := {
	"Theme1": preload("res://Audio/music/FutureAmbient_1.wav"),
	"Theme2": preload("res://Audio/music/FutureAmbient_3.wav"),
	"DialogTheme": preload("res://Audio/music/HipHopNoir_1.wav"),
	"BattleTheme1": preload("res://Audio/music/DarkDnB_2.wav")
	}
export var sfx_dict := {
	"ThunderClap1" : preload("res://Audio/sfx/ThunderClap.mp3"),
	"ThunderStorm" : preload("res://Audio/sfx/thunderstorm2.wav")
}	
var preload_dict = {}
var character_dict = {}
var player_dict = {
	"player_name" : "steebo"
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
	print("Global Ready")
	pass # Replace with function body.

func start_game():
	print("Global starting game")
	_music_player.stop()
	SceneManager.change_scene("res://Scenes/Cutscenes/Intro_1.tscn")

func play_audio(track : String):
	if audio_dict.has(track):
		_music_player.set_stream(audio_dict[track])
		_music_player.play()
	else:
		print("Track %s not found" % track)

func play_sfx(track : String):
	if sfx_dict.has(track):
		_sfx_player.set_stream(sfx_dict[track])
		_sfx_player.play()
	else:
		print("SFX track %s not found" % track)
	
func _on_quit_requested():
	_music_player.stop()
	play_audio("Theme1")
	SceneManager.change_scene("res://Scenes/StartScreen/StartScreen.tscn")



