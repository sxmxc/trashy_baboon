extends Node


onready var music_player = $MusicPlayer
onready var sfx_player = $SfxPlayer
onready var utilities = $Utils
onready var root = get_tree().root

var world = null


enum STATS {HP, MP, MGATK, MGDEF, SPEED}

var preload_dict = {
	"Player" : preload("res://CharacterSystem/Scenes/Player/Player.tscn"),
	"WorldNPC" : preload("res://CharacterSystem/Scenes/WorldNPC.tscn"),
	"World" : preload("res://Scenes/GameWorld.tscn")
}


var character_dict = {
	"Player" : preload("res://CharacterSystem/Resources/Player/player.tres"),
	"Alpha" : preload("res://CharacterSystem/Resources/Characters/alpha.tres"), 
	"Beta" : preload("res://CharacterSystem/Resources/Characters/beta.tres")
}

var player_dict = {
	"player_name" : "steebo"
}
var level_dict = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	EventBus.connect("quit_requested",self, "_on_quit_requested")
	if not world:
		world = preload_dict.World.instance()
		root.call_deferred("add_child",world)
	print("Global Ready")
	pass # Replace with function body.

func start_game():
	print("Global starting game")
	var player = world.get_node_or_null("Player")
	if player == null:
		player = preload_dict.Player.instance()
	SceneManager.change_scene("res://Scenes/Cutscenes/Intro_1.tscn")
	yield(SceneManager, "scene_loaded")
	world.add_child(player)
	player.add_member(character_dict.Player, true)
	player.change_name(character_dict.Player, player_dict.player_name)
	player.set_active_member(player_dict.player_name)
	player.add_member(character_dict.Alpha, false)
	player.update_known_convictions()

func start_battle():
	print("Start battle called")
	EventBus.emit_signal("battle_begin")
	yield(EventBus,"transition_ready")
	print("transition_ready singal received, changing to battlemap")
	world.change_map("test_battle_map")
	

func dialog_ended():
	EventBus.emit_signal("cutscene_ended", Dialogic.get_variable("survival_gain") as int, Dialogic.get_variable("strength_gain") as int, Dialogic.get_variable("peace_gain") as int)
	Dialogic.clear_all_variables()	
	print("Dialog variables cleared. New:\nSurvival: %d Strength %d Peace %d" % [Dialogic.get_variable("survival_gain") as int, Dialogic.get_variable("strength_gain") as int, Dialogic.get_variable("peace_gain") as int])

func _on_quit_requested():
	SceneManager._current_scene = world
	SceneManager.change_scene("res://Scenes/StartScreen/StartScreen.tscn")
