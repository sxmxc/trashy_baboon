extends ParallaxBackground


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	set_process(true)
	pass # Replace with function body.

func _process(_delta):
	scroll_offset += Vector2(.1,.1)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
