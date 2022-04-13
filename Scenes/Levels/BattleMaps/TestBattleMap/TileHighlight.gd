extends Position2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	EventBus.connect("mouse_grid_position_updated", self, "_on_mouse_grid_position_updated")
	pass # Replace with function body.


func _on_mouse_grid_position_updated(_grid_position, world_position, offset):
	set_position(world_position + offset)
