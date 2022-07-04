tool
class_name Unit
extends Path2D

signal walk_finished
signal turn_complete

signal action_selected

var grid
var gameboard
var rng = RandomNumberGenerator.new()

var initialized = false

export var ai_controlled := false

var cell := Vector2.ZERO setget set_cell
var is_selected := false setget set_is_selected
var _is_walking := false setget _set_is_walking

#data
export (Resource) var character_data setget set_data
export (String) var character_name
export var skin: Texture setget set_skin
export var skin_offset := Vector2.ZERO setget set_skin_offset
var move_range := 6
var move_speed := 600.0
export var stats = {}

var current_action_points

onready var _sprite: Sprite = $PathFollow2D/Sprite
onready var _anim_player: AnimationPlayer = $AnimationPlayer
onready var _path_follow: PathFollow2D = $PathFollow2D
onready var camera = $Camera2D
onready var ai = $AI
onready var action_menu = $ActionsUI/ActionMenu

func _init():
	pass

func _ready() -> void:
	if Engine.editor_hint:
		return
	if !ai_controlled:
		ai.set_process(false)
	EventBus.connect("conviction_equipped", self, "_on_conviction_equipped")
	rng.seed = OS.get_ticks_msec()
	rng.randomize()
	display_actions(false)
	set_process(false)
	_update_actions()
	self.cell = grid.calculate_grid_coordinates(position)
	position = grid.calculate_map_position(cell)
	

	if not Engine.editor_hint:
		curve = Curve2D.new()
		
	var points := []
	walk_along(PoolVector2Array(points))
	print("UNIT: Unit %s ready." % character_name)

func _on_conviction_equipped(convictions):
	stats['equipped_convictions'] = convictions

func _update_actions():
	var actions = []
	for action in stats["equipped_convictions"]:
		actions.append(Global.conviction_dictionary[action].conviction_battle_ability)
	action_menu.add_actions(actions)

func _process(delta: float) -> void:
	if Engine.editor_hint:
		return
	_path_follow.offset += move_speed * delta

	if _path_follow.unit_offset >= 1.0:
		self._is_walking = false
		_path_follow.offset = 0.0
		position = grid.calculate_map_position(cell)
		curve.clear_points()
		emit_signal("walk_finished")


func play_turn():
	current_action_points = stats["action_points"]
	_update_actions()
	if !ai_controlled:
		display_actions(true)
		var action = yield(self, "action_selected")
		print("UNIT: Action selected %s" % action)
		display_actions(false)
		while !action == "end_turn" and current_action_points > 0:
			match action:
				"end_turn":
					display_actions(false)
					return
				"move":
					gameboard.move_unit(self)
					yield(self, "walk_finished")
					current_action_points -= 1
					if current_action_points < 0:
						current_action_points = 0
					EventBus.emit_signal("action_points_updated", current_action_points)
					EventBus.emit_signal("battle_message", "%s: Moved" % self.character_name)
				"de-escalate":
					var rando = rng.randi_range(1,20)
					if rando >= 10:
						print("De-escalate success with %s" % rando)
						EventBus.emit_signal("battle_message", "%s: De-escalate success" % self.character_name)
						EventBus.emit_signal("battle_end", true)
						return
					print("UNIT: De-escalate failure with %s" % rando)
					EventBus.emit_signal("battle_message", "%s: De-escalate failure" % self.character_name)
					return
				"attack":
					current_action_points -= 1
					if current_action_points < 0:
						current_action_points = 0
					EventBus.emit_signal("action_points_updated", current_action_points)
					EventBus.emit_signal("battle_message", "%s: Attacked" % self.character_name)
			display_actions(true)
			
			action = yield(self, "action_selected")
			print("UNIT: Action selected %s" % action)
			display_actions(false)
		return
	else:
		ai.unit = self
		ai.ai_control = ai_controlled
		ai.gameboard = gameboard
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
	position = grid.calculate_map_position(cell)

func set_data(data: CharacterData):
	if Engine.editor_hint:
		return
	if !initialized:
		if data:
			print("UNIT: Unit setting data for %s" % data.character_name)
			character_data = data
			character_name = data.character_name
			stats["max_health"] = data.base_health_max
			stats['max_move_speed'] = data.base_speed
			stats['move_range'] = data.base_range
			stats['action_points'] = data.base_action_points
			stats['equipped_convictions'] = data.equipped_convictions
			move_speed = stats.max_move_speed
			move_range = stats.move_range
			skin = data.char_sprite
			initialized = true
	pass

func set_is_selected(value: bool) -> void:
	is_selected = value
	if is_selected:
		_anim_player.play("selected")
		
	else:
		_anim_player.play("idle")
		

func display_actions(value):
	action_menu.visible = value
	EventBus.emit_signal("request_hide_cursor", value)


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
	return stats.equipped_convictions


func _on_ActionMenu_action_pressed(action):
	emit_signal("action_selected", action)
	pass # Replace with function body.


func _on_ActionMenu_visibility_changed():
	
	pass # Replace with function body.
