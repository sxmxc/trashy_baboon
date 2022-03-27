extends Node
class_name CharacterConvictions

var convictions = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func initialize(stats: StartingStats):
	for conviction in stats.starting_convictions:
		convictions[conviction.name] = conviction

func apply_conviction_experience(conv_name, value):
	if convictions.has(conv_name):
		convictions[conv_name].apply_experience(value)

func equip_conviction(conviction : Conviction):
	if !convictions.has(conviction.name):
		convictions[conviction.name] = conviction
		
func unequip_conviction(conviction : Conviction):
	if convictions.has(conviction):
		convictions.erase(conviction.name)
