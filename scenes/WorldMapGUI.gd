extends CanvasLayer


export (Dictionary) var campsite_dict = {
	0 : "res://scenes/Campsites/Campsite0.tscn",
	1 : "res://scenes/Campsites/Campsite1.tscn"
}


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_CampButton_pressed():
	if Global.player_town_idx % 2:
		SceneManager.change_scene(campsite_dict[0])
	else:
		SceneManager.change_scene(campsite_dict[1])
	pass # Replace with function body.
