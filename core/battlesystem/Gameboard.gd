class_name GameBoard
extends Node2D

const DIRECTIONS = [Vector2.LEFT, Vector2.RIGHT, Vector2.UP, Vector2.DOWN]

export (NodePath) var grid

var data_loaded = false

var _units := {}
var _active_unit: Unit
var _walkable_cells := []

onready var _unit_overlay: UnitOverlay = $UnitOverlay
onready var _unit_path: UnitPath = $UnitPath
onready var turn_queue = $TurnQueue

export (PackedScene) var unit_scene

var rng = RandomNumberGenerator.new()

func _ready() -> void:
	turn_queue.connect("turn_finished", self, "_set_active_unit")
	rng.seed = OS.get_time().second
	rng.randomize()
	yield(get_parent(),"ready")
	_reinitialize()
	print("GB: Gameboard ready")

func set_grid(xgrid : Grid):
	grid = xgrid

func is_occupied(cell: Vector2) -> bool:
	return true if _units.has(cell) else false


func get_walkable_cells(unit: Unit) -> Array:
	return _flood_fill(unit.cell, unit.move_range)

func load_data(units_data: Array) -> void:
	if !data_loaded:
		_units.clear()
		for data in units_data:
			print("GB: Gameboard loading data for unit %s" % data.data.character_name)
			var unit = unit_scene.instance()
			var rand_coord = Vector2(rng.randi_range(0, grid.size.x -1),rng.randi_range(0, grid.size.y -1))
			while is_occupied(rand_coord):
				rand_coord = Vector2(rng.randi_range(0, grid.size.x -1),rng.randi_range(0, grid.size.y -1))
			unit.set_data(data["data"] as CharacterData)
			if data.recruited == false:
				unit.ai_controlled = true
			unit.grid = grid
			unit.cell = rand_coord
			turn_queue.add_child(unit)
		data_loaded = true

func _reinitialize() -> void:
	print("GB: Gameboard reinitializing")
	_units.clear()
	for child in turn_queue.get_children():
		var unit := child as Unit
		if not unit:
			continue
		_units[unit.cell] = unit
		unit.gameboard = self
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
	print("GB: Gameboard _select_unit")
	if not _units.has(cell):
		return
	print(_units[cell])
	_active_unit = _units[cell]
	_active_unit.is_selected = true
	_walkable_cells = get_walkable_cells(_active_unit)
	_unit_overlay.draw(_walkable_cells)
	_unit_path.initialize(_walkable_cells)
	_active_unit.camera.current = true
	EventBus.emit_signal("active_unit_changed", _active_unit)

func _set_active_unit(unit : Unit):
	print("GB: Gameboard _set_active_unit")
	_active_unit = unit
	_active_unit.is_selected = true
	_active_unit.camera.current = true
	_active_unit.camera.reset()
	EventBus.emit_signal("active_unit_changed", _active_unit)
	turn_queue.play_turn()
	
func get_active_unit() -> Unit:
	return _active_unit
	
func move_unit(unit : Unit):
	print("GB: Gameboard move_unit")
	get_active_unit_walkable(unit)

func get_active_unit_walkable(unit : Unit):
	print("GB: Gameboard get_active_unit_walkable")
	EventBus.emit_signal("request_hide_cursor", false)
	_active_unit = unit
	_active_unit.is_selected = true
	_walkable_cells = get_walkable_cells(_active_unit)
	_unit_overlay.draw(_walkable_cells)
	_unit_path.initialize(_walkable_cells)
	if unit.ai_controlled:
		_active_unit.ai.walkable_cells = get_walkable_cells(_active_unit)
		_active_unit.ai.gameboard = self

func _deselect_active_unit() -> void:
	print("GB: Gameboard _deselect_active_unit")
	_active_unit.is_selected = false
	_unit_overlay.clear()
	_unit_path.stop()


func _clear_active_unit() -> void:
	print("GB: Gameboard _clear_active_unit")
	_active_unit = null
	_walkable_cells.clear()
	


func move_active_unit(new_cell: Vector2) -> bool:
	print("GB: Gameboard move_active_unit")
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
