extends Node


onready var music_player = $MusicPlayer
onready var sfx_player = $SfxPlayer
onready var utilities = $Utils
onready var root = get_tree().root

var world


enum STATS {HP, MP, MGATK, MGDEF, SPEED}

var preload_dict = {
	"Player" : preload("res://CharacterSystem/Scenes/Player/Player.tscn"),
	"World" : preload("res://Scenes/World.tscn")
}

var player_party_member = preload("res://CharacterSystem/Resources/Player/player.tres")

var player_dict = {
	"player_name" : "steebo"
}
var level_dict = {}
var character_dict = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func start_game():
	world = preload_dict.World.instance()
	root.add_child(world)
	var player = world.get_node_or_null("Player")
	if player == null:
		player = preload_dict.Player.instance()
		player.add_member(player_party_member, true)
		player.change_name(player_party_member, player_dict.player_name)
		player.set_active_member(player_dict.player_name)
	else:
		player.add_member(player_party_member, true)
	SceneManager.change_scene("res://Scenes/Cutscenes/Intro_1.tscn")
	yield(SceneManager, "scene_loaded")
	world.add_child(player)
	
	
#func register_character(value: Character):
#	character_dict[value.get_character_name()] = value
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
