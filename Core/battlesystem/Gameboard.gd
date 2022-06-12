class_name GameBoard
extends Node2D

const DIRECTIONS = [Vector2.LEFT, Vector2.RIGHT, Vector2.UP, Vector2.DOWN]

export (NodePath) var grid

var _units := {}
var _active_unit: Unit
var _walkable_cells := []

onready var _unit_overlay: UnitOverlay = $UnitOverlay
onready var _unit_path: UnitPath = $UnitPath
onready var turn_queue = $TurnQueue


func _ready() -> void:
	turn_queue.connect("turn_finished", self, "_set_active_unit")
	yield(get_parent(),"ready")
	_reinitialize()

func set_grid(xgrid : Grid):
	grid = xgrid

func is_occupied(cell: Vector2) -> bool:
	return true if _units.has(cell) else false


func get_walkable_cells(unit: Unit) -> Array:
	return _flood_fill(unit.cell, unit.move_range)


func _reinitialize() -> void:
	_units.clear()

	for child in turn_queue.get_children():
		var unit := child as Unit
		if not unit:
			continue
		_units[unit.cell] = unit
	turn_queue.initialize()
	_set_active_unit(turn_queue.active_character as Unit)

func _flood_fill(cell: Vector2, max_distance: int) -> Array:
	var array := []
	var stack := [cell]
	while not stack.empty():
		var current = stack.pop_back()

		if not grid.is_within_bounds(current):
			continue
		if current in array:
			continue

		var difference: Vector2 = (current - cell).abs()
		var distance := int(difference.x + difference.y)
		if distance > max_distance:
			continue

		array.append(current)
		for direction in DIRECTIONS:
			var coordinates: Vector2 = current + direction
			if is_occupied(coordinates):
				continue
			if coordinates in array:
				continue

			stack.append(coordinates)
	return array


func _select_unit(cell: Vector2) -> void:
	if not _units.has(cell):
		return
	_active_unit = _units[cell]
	_active_unit.is_selected = true
	_walkable_cells = get_walkable_cells(_active_unit)
	_unit_overlay.draw(_walkable_cells)
	_unit_path.initialize(_walkable_cells)
	_active_unit.camera.current = true
	EventBus.emit_signal("active_unit_changed", _active_unit)

func _set_active_unit(unit : Unit):
	_active_unit = unit
	_active_unit.is_selected = true
	_walkable_cells = get_walkable_cells(_active_unit)
	_unit_overlay.draw(_walkable_cells)
	_unit_path.initialize(_walkable_cells)
	if unit.ai_controlled:
		_active_unit.ai.walkable_cells = get_walkable_cells(_active_unit)
		_active_unit.ai.gameboard = self
	_active_unit.camera.current = true
	_active_unit.camera.reset()
	EventBus.emit_signal("active_unit_changed", _active_unit)
	turn_queue.play_turn()

func _deselect_active_unit() -> void:
	_active_unit.is_selected = false
	_unit_overlay.clear()
	_unit_path.stop()


func _clear_active_unit() -> void:
	_active_unit = null
	_walkable_cells.clear()
	


func move_active_unit(new_cell: Vector2) -> bool:
	if is_occupied(new_cell) or not new_cell in _walkable_cells:
		return false
	_units.erase(_active_unit.cell)
	_units[new_cell] = _active_unit
	_deselect_active_unit()
	_active_unit.walk_along(_unit_path.current_path)
	yield(_active_unit, "walk_finished")
	_clear_active_unit()
	return true


func _on_Cursor_moved(new_cell: Vector2) -> void:
	if _active_unit and !_active_unit.ai_controlled:
		draw_unit_path(new_cell)

func draw_unit_path(new_cell: Vector2) -> void:
	if _active_unit and _active_unit.is_selected:
		_unit_path.draw(_active_unit.cell, new_cell)


func _on_Cursor_accept_pressed(cell: Vector2) -> void:
	if not _active_unit:
		_select_unit(cell)
	elif _active_unit.is_selected and !_active_unit.ai_controlled:
		move_active_unit(cell)


func _input(event: InputEvent) -> void:
	if _active_unit and event.is_action_pressed("ui_cancel"):
		_deselect_active_unit()
		_clear_active_unit()
		get_tree().set_input_as_handled()
