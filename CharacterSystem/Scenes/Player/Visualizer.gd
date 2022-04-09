extends Node2D

var player = null
var world_offset = Vector2()

const RED = Color(1.0,0,0)
const GREEN = Color(0,1.0,0)
var color = GREEN



func _ready():
	player = get_parent()
	set_as_toplevel(true)
	set_process_input(true)

func _input(event):
	if event.is_action_pressed("ui_debug"):
		visible = not visible
		set("visibility/visible", visible)
		set_process(visible)


func _draw():
	draw_circle(player.target_pos, 6, color)

func _process(delta):
	var pos = player.get_position()
	var target_pos = player.target_pos
	if pos != target_pos: color = GREEN
	elif pos == target_pos and not player.is_moving and player.direction == Vector2(): color = GREEN
	else: color = RED
	update()
