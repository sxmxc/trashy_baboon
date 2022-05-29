extends Node


onready var _music_player = $MusicPlayer as AudioStreamPlayer2D
onready var _sfx_player = $SfxPlayer as AudioStreamPlayer2D
onready var utilities = $Utils
onready var root = get_tree().root

var menu_opened = false

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
var level_dict = {}

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

func dialog_ended():
	EventBus.emit_signal("cutscene_ended", Dialogic.get_variable("survival_gain") as int, Dialogic.get_variable("strength_gain") as int, Dialogic.get_variable("peace_gain") as int)
	Dialogic.clear_all_variables()	
	print("Dialog variables cleared. New:\nSurvival: %d Strength %d Peace %d" % [Dialogic.get_variable("survival_gain") as int, Dialogic.get_variable("strength_gain") as int, Dialogic.get_variable("peace_gain") as int])
	SceneManager.change_scene("res://core/battlesystem/BattleScene.tscn")
	play_audio("BattleTheme1")
func _on_quit_requested():
	play_audio("Theme1")
	SceneManager.change_scene("res://Scenes/StartScreen/StartScreen.tscn")
