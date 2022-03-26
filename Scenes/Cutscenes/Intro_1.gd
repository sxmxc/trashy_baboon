extends Node2D



# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	Dialogic.set_variable('player_name', Global.player_dict.player_name)
	var dialog = Dialogic.start("intro_1")
	dialog.connect("timeline_end", self, "change_to_world")
	add_child(dialog)
	pass # Replace with function body.

func change_to_world(_arg):
	SceneManager.change_scene("res://Scenes/World.tscn")
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
