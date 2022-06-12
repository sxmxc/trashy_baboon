tool
class_name Unit
extends Path2D

signal walk_finished
signal turn_complete

var grid
export (String) var character_name
export var skin: Texture setget set_skin
export var move_range := 6
export var skin_offset := Vector2.ZERO setget set_skin_offset
export var move_speed := 600.0
export var stats = {}
export var ai_controlled := false
export (Resource) var character_data setget set_data
var cell := Vector2.ZERO setget set_cell
var is_selected := false setget set_is_selected
var _is_walking := false setget _set_is_walking

onready var _sprite: Sprite = $PathFollow2D/Sprite
onready var _anim_player: AnimationPlayer = $AnimationPlayer
onready var _path_follow: PathFollow2D = $PathFollow2D
onready var camera = $Camera2D
onready var ai = $AI

func _ready() -> void:
	set_process(false)
	yield(get_parent().get_parent().get_parent(),"ready")
	grid = get_parent().get_parent().grid

	self.cell = grid.calculate_grid_coordinates(position)
	position = grid.calculate_map_position(cell)

	if not Engine.editor_hint:
		curve = Curve2D.new()
	
	var points := []
	walk_along(PoolVector2Array(points))


func _process(delta: float) -> void:
	_path_follow.offset += move_speed * delta

	if _path_follow.unit_offset >= 1.0:
		self._is_walking = false
		_path_follow.offset = 0.0
		position = grid.calculate_map_position(cell)
		curve.clear_points()
		emit_signal("walk_finished")
		if !ai_controlled:
			emit_signal("turn_complete")


func play_turn():
	if !ai_controlled:
		yield(self, "turn_complete")
		return
	else:
		ai.unit = self
		ai.ai_control = ai_controlled
		yield(ai, "end_turn")
		return

func walk_along(path: PoolVector2Array) -> void:
	if path.empty():
		return

	curve.add_point(Vector2.ZERO)
	for point in path:
		curve.add_point(grid.calculate_map_position(point) - position)
	cell = path[-1]
	self._is_walking = true


func set_cell(value: Vector2) -> void:
	cell = grid.clamp(value)

func set_data(data: Resource):
	if data:
		character_data = data
		character_name = data.character_name
		stats["max_health"] = data.base_health_max
		stats['max_move_speed'] = data.base_speed
		stats['move_range'] = data.base_range
		move_speed = stats.max_move_speed
		move_range = stats.move_range
		skin = data.char_sprite
	pass

func set_is_selected(value: bool) -> void:
	is_selected = value
	if is_selected:
		_anim_player.play("selected")
	else:
		_anim_player.play("idle")


func set_skin(value: Texture) -> void:
	skin = value
	if not _sprite:
		yield(self, "ready")
	_sprite.texture = value


func set_skin_offset(value: Vector2) -> void:
	skin_offset = value
	if not _sprite:
		yield(self, "ready")
	_sprite.position = value


func _set_is_walking(value: bool) -> void:
	_is_walking = value
	set_process(_is_walking)

func _get_available_actions() -> Array:
	return []
