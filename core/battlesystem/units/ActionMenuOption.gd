extends TextureButton


export (String) var option_display
export (String) var option_action
export (Texture) var option_icon


# Called when the node enters the scene tree for the first time.
func _ready():
	texture_normal = option_icon
	name = option_display
	hint_tooltip = option_display
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
