extends Node


func file_exists(path) -> bool:
	var f = File.new()
	return f.file_exists(path)

func cartesian_to_isometric(cartesian):
	var isometric = Vector2()
	#cartesian.x = cartesian.x * -1
	isometric.x = cartesian.x - cartesian.y
	isometric.y = cartesian.x / 2 + cartesian.y / 2
	return isometric

# Reparent a node under a new parent.
# Optionally updates the transform to mantain the current
# position, scale and rotation values.
func reparent_node(node: Node2D, new_parent, update_transform = false):
	var previous_xform = node.global_transform
	node.get_parent().remove_child(node)
	new_parent.add_child(node)
	if update_transform:
		node.global_transform = previous_xform
