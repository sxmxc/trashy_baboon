extends Node2D
class_name GameWorld

onready var tween = $WorldUI/Tween
onready var transition = $WorldUI/ScreenTransition

var map_dictionary = {
	"test_battle_map" : preload("res://Scenes/Levels/BattleMaps/TestBattleMap/TestBattleMap.tscn"),
	"test_town": preload("res://Scenes/Levels/TownMaps/TestTown/TestTown.tscn"), 
	"test_overworld": preload("res://Scenes/Levels/OverworldMaps/TestOverworld.tscn")
}

var map_instances = {}
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var current_map
var previous_map
var current_tilemap

# Called when the node enters the scene tree for the first time.
func _ready():
	EventBus.connect("battle_begin", self, "_on_battle_begin")
	EventBus.connect("battle_end", self, "_on_battle_end")
	pass # Replace with function body.
	
func change_map(map):
	previous_map = current_map
	instance_map(map)
	var player = get_tree().get_nodes_in_group("player")[0]
	if player:
		Global.utilities.reparent_node(player, map_instances[map].get_node("TileMap/YSort"))
	if previous_map:
		remove_child(previous_map)
	add_child(map_instances[map])
	current_map = map_instances[map]
	current_tilemap = current_map.get_node("TileMap")
	print("Map change complete. Sending map_changed signal")
	EventBus.emit_signal("map_changed", current_map)
	
func instance_map(map):
	if map_dictionary.has(map):
		if !map_instances.has(map):
			map_instances[map] = map_dictionary[map].instance()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _on_battle_begin():
	print("battle_begin signal received, starting transition in")
	_battle_transition_in()
	yield(EventBus, "map_changed")
	print("map_changed signal received, starting transition out")
	_battle_transition_out()	
	
	
func _on_battle_end():
	change_map(previous_map.name)

func _battle_transition_in():
	tween.interpolate_property(transition.material,"shader_param/progress", 0, 1, 1, Tween.TRANS_CUBIC, Tween.EASE_OUT)
	tween.start()
	yield(tween, "tween_completed")
	EventBus.emit_signal("transition_ready")
	
func _battle_transition_out():
	tween.interpolate_property(transition.material,"shader_param/progress", 1, 0, 1, Tween.TRANS_CUBIC, Tween.EASE_IN)
	tween.start()
	yield(tween, "tween_completed")
	EventBus.emit_signal("transition_end")
