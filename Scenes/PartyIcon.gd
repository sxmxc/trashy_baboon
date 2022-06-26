extends PathFollow2D


onready var _tween = $Tween

var _curve: Curve2D
var _moving:= false

var _target:= 0


# Called when the node enters the scene tree for the first time.
func _ready():
	_tween.connect("tween_completed", self, "_on_tween_finish")
	pass # Replace with function body.

func initialize(curve: Curve2D):
	_curve = curve
	offset = _curve.get_closest_offset(_curve.get_point_position(Global.player_town_idx))
	pass

func _physics_process(delta):
	pass

func set_target(target: int):
	_target = target
	_moving = true
	_tween.interpolate_property(self, 
	"offset", _curve.get_closest_offset(position), 
	_curve.get_closest_offset(_curve.get_point_position(_target)),
	1, Tween.TRANS_LINEAR)
	_tween.start()
	pass

func _on_tween_finish(tween: Object, path: NodePath):
	_moving = false

