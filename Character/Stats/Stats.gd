extends Node
class_name CharacterStats

signal health_changed(new_health)
signal health_depleted()

var hp
var mp 
var max_hp setget set_max_hp
var max_mp setget set_max_mp
var magic_attack 
var magic_defense 
var speed 
var character_level

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func initialize(stats : StartingStats):
	max_hp = stats.max_hp
	max_mp = stats.max_mp
	hp = max_hp
	mp = max_mp
	magic_attack = stats.magic_attack
	magic_defense = stats.magic_defense
	speed = stats.speed
	character_level = stats.character_level

func set_max_hp(value):
	max_hp = value

func set_max_mp(value):
	max_mp = value
	
