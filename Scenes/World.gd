extends Node2D


var map_dictionary = {
	"test_battle_map" : preload("res://Scenes/Levels/BattleMaps/TestBattleMap.tscn"),
	"test_town": preload("res://Scenes/Levels/TownMaps/TestTown.tscn"), 
	"test_overworld": preload("res://Scenes/Levels/OverworldMaps/TestOverworld.tscn")
}

var map_instances = {}
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var current_map
var current_tilemap

# Called when the node enters the scene tree for the first time.
func _ready():
	if get_child_count() == 0:
		change_map("test_town")
	pass # Replace with function body.
	
func change_map(map):
	instance_map(map)
	for child in get_children():
		remove_child(child)
	add_child(map_instances[map])
	
func instance_map(map):
	if map_dictionary.has(map):
		if !map_instances.has(map):
			map_instances[map] = map_dictionary[map].instance()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
