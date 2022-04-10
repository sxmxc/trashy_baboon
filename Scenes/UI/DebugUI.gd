extends CanvasLayer
onready var player_position_text = $PlayerGridPos


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	EventBus.connect("player_grid_position_updated", self, "_on_player_grid_position_change")
	pass # Replace with function body.

func _on_player_grid_position_change(new_position):
	player_position_text.text = "Player Position: %s" % new_position
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
