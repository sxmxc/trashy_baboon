extends Node2D
class_name TurnQueue

var active_character
signal turn_finished(next)

func initialize():
	var units = get_units_in_queue()
	units.sort_custom(self, 'sort_units')
	for unit in units:
		unit.raise()
	active_character = get_child(0)
	EventBus.emit_signal("battle_queue_updated",units)

func play_turn():
	yield(active_character.play_turn(), "completed")
	var new_index : int = (active_character.get_index() + 1) % get_child_count()
	active_character = get_child(new_index)
	emit_signal("turn_finished", active_character)

static func sort_units(a : Unit, b : Unit) -> bool:
	return a.move_speed > b.move_speed

func get_units_in_queue() -> Array:
	return get_children()
