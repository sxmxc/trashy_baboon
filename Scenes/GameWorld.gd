extends Node2D
class_name GameWorld

onready var tween = $WorldUI/Tween
onready var transition = $WorldUI/ScreenTransition
onready var battle_cache = $BattleCache

var map_dictionary = {}

var map_instances = {}
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var current_map
var previous_map
var current_tilemap

var battlers = {}
# Called when the node enters the scene tree for the first time.
func _ready():
	EventBus.emit_signal("game_world_ready")
	pass # Replace with function body.
	

	
func _on_active_map_set(map):
	previous_map = current_map
	current_map = map
	current_tilemap = current_map.get_node("TileMap")	
	
func instance_map(map):
	if map_dictionary.has(map):
		if !map_instances.has(map):
			map_instances[map] = map_dictionary[map].preload.instance()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _on_battle_begin():
	print("battle_begin signal received, starting transition out")
	_battle_transition_out()
	yield(EventBus, "map_changed")
	print("map_changed signal received, registering battlers and transitioning in")
	map_instances["test_battle_map"].clear_queue()
	for battler in battlers:
		map_instances["test_battle_map"].add_battler(battler)
	_battle_transition_in()	
	
	
#func _on_battle_end():
#	change_map(previous_map.name)

func _battle_transition_out():
	tween.interpolate_property(transition.material,"shader_param/progress", 0, 1, 1, Tween.TRANS_CUBIC, Tween.EASE_OUT)
	tween.start()
	yield(tween, "tween_completed")
	EventBus.emit_signal("transition_ready")
	
func _battle_transition_in():
	tween.interpolate_property(transition.material,"shader_param/progress", 1, 0, 1, Tween.TRANS_CUBIC, Tween.EASE_IN)
	tween.start()
	yield(tween, "tween_completed")
	EventBus.emit_signal("transition_end")
