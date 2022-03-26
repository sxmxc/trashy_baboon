extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var music_player = $MusicPlayer
onready var sfx_player = $SfxPlayer
onready var utilities = $Utils

var player_dict = {
	"player_name" : "steebo"
}
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func start_game():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
