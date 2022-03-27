extends Node


onready var music_player = $MusicPlayer
onready var sfx_player = $SfxPlayer
onready var utilities = $Utils

var player_dict = {
	"player_name" : "steebo"
}
var level_dict = {}
var character_dict = {
}
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func start_game():
	pass
	
func register_character(value: Character):
	character_dict[value.get_character_name()] = value
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
