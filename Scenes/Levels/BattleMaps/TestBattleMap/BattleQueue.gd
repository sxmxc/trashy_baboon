extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export (Array) var queue = []

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func add_to_queue(member: WorldMember):
	queue.append(member)
	

func sort_queue() -> Array :
	return queue.sort_custom(QueueSorter, "sort_ascending")
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
class QueueSorter:
	static func sort_ascending(a: WorldMember, b :WorldMember):
		if a.speed < b.speed:
			return true
		return false
	static func sort_descending(a: WorldMember, b: WorldMember):
		if a.speed > b.speed:
			return true
		return false
