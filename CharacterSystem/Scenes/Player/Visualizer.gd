extends Node2D

var Player = null
var world_offset = Vector2()

const RED = Color(1.0,0,0)
const GREEN = Color(0,1.0,0)
var color = GREEN



func _ready():
	Player = get_parent()
	var WorldNode = get_parent()
	world_offset = WorldNode.position
	set_as_toplevel(true)
	set_process_input(true)

func _input(event):
	if event.is_action_pressed("ui_debug"):
		visible = not visible
		set("visibility/visible", visible)
		set_process(visible)


func _draw():
	draw_circle(Player.target_pos + world_offset, 6, color)

func _process(delta):
	var pos = Player.position
	var target_pos = Player.target_pos
	if pos != target_pos: color = GREEN
	elif pos == target_pos and not Player.is_moving and Player.direction == Vector2(): color = GREEN
	else: color = RED
	update()
