extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var _err = EventBus.connect("cutscene_ended", self,"_on_cutscene_ended")
	_err = EventBus.connect("conviction_xp_gained", self, "_on_conviction_xp_gain")
	pass # Replace with function body.

func _on_cutscene_ended(val1, val2, val3):
	print_debug("Cutscene ended. Gains:\nSurvival: %d Strength %d Peace %d" % [val1,val2,val3])
	pass

func _on_conviction_xp_gain(name, amount):
	print_debug("Conviction XP Gain.\nConviction: %s Amount: %d" % [name,amount])
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
