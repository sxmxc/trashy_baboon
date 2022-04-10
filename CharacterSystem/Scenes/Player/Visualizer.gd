extends Node2D

var player = null
var world_offset = Vector2()

const RED = Color(1.0,0,0)
const GREEN = Color(0,1.0,0)
var color = GREEN

var draw_position =  Vector2.ZERO



func _ready():
	EventBus.connect("player_grid_position_updated", self, "_on_player_grid_position_change")
	player = owner
	set_as_toplevel(true)
	set_process_input(true)

func _input(event):
	if event.is_action_pressed("ui_debug"):
		visible = not visible
		set("visibility/visible", visible)
		set_process(visible)


func _draw():
	draw_circle(draw_position, 6, color)

func _process(_delta):
	var pos = player.get_position()
	var target_pos = player.target_pos
	if pos != target_pos: color = GREEN
	elif pos == target_pos and not player.is_moving and player.direction == Vector2(): color = GREEN
	else: color = RED
	draw_position = player.target_pos
	update()

func _on_player_grid_position_change(_pos):
	draw_position = player.get_position()
	update()
