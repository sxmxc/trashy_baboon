extends CanvasLayer
onready var player_position_text = $PlayerGridPos
onready var mouse_position_text = $MouseGridPos

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	EventBus.connect("player_grid_position_updated", self, "_on_player_grid_position_change")
	EventBus.connect("mouse_grid_position_updated",self,"_on_mouse_grid_position_change")
	pass # Replace with function body.

func _on_player_grid_position_change(new_position):
	player_position_text.text = "Player Grid Position: %s" % new_position

func _on_mouse_grid_position_change(grid_position, world_position, offset):
	mouse_position_text.text = "Mouse Grid Position: %s, World Position %s, Offset %s" % [grid_position, world_position, offset]
