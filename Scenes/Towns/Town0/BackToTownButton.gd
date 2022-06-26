extends TextureButton


var _hovered = false
onready var select_icon = $SelectIcon
onready var anim = $AnimationPlayer


# Called when the node enters the scene tree for the first time.
func _ready():
	self.connect("mouse_entered", self, "_on_button_mouse_entered")
	self.connect("mouse_exited", self, "_on_button_mouse_exited")
	pass # Replace with function body.

func _process(_delta):
	if _hovered and !disabled:
		select_icon.visible = true
	else:
		select_icon.visible = false
	pass

func _on_BackToTownButton_pressed():
	SceneManager.change_scene("res://scenes/Towns/Town0/town_0.tscn")
	pass # Replace with function body.


func _on_button_mouse_entered():
	_hovered = true
	anim.play("icon_hover")
	pass # Replace with function body.


func _on_button_mouse_exited():
	_hovered = false
	anim.stop()
	pass # Replace with function body.
