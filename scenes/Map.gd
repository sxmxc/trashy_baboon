extends Navigation2D

export(float) var CHARACTER_SPEED = 400.0
var path = []

#func _input(event):
#	if not event.is_action_pressed('click'):
#		return
#	update_navigation_path($Character.position, get_local_mouse_position())
	
func update_navigation_path(start_position, end_position):
	path = get_simple_path(start_position, end_position, true)
	path.remove(0)
	set_process(true)

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var walk_distance = CHARACTER_SPEED * delta
	move_along_path(walk_distance)
	pass
	
func move_along_path(distance):
	var last_point = $Character.position 
	for _index in range(path.size()):
		var distance_between_points = last_point.distance_to(path[0])
		if distance <= distance_between_points:
			$Character.set_position(last_point.linear_interpolate(path[0], distance / distance_between_points))
			break
		elif distance < 0.0:
			$Character.position = path[0]
			set_process(false)
			break
		distance -= distance_between_points
		last_point = path[0]
		path.remove(0)
