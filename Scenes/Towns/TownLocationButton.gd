extends TextureButton


onready var select_icon = $SelectIcon
onready var anim = $AnimationPlayer

export (PackedScene) var location_to_load


var _hovered = false


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if _hovered:
		select_icon.visible = true
	else:
		select_icon.visible = false
	pass


func _on_TownLocationButton_mouse_entered():
	_hovered = true
	anim.play("icon_hover")
	pass # Replace with function body.


func _on_TownLocationButton_mouse_exited():
	_hovered = false
	anim.stop()
	pass # Replace with function body.

func _on_TownLocationButton_pressed():
	if location_to_load != null:
		SceneManager.change_scene(location_to_load.resource_path)
	pass # Replace with function body.

