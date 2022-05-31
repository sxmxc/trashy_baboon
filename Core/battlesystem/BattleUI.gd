extends CanvasLayer

onready var active_unit_label = $MarginContainer/ActiveUnitLabel
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	EventBus.connect("active_unit_changed", self, "_on_active_unit_change")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _on_active_unit_change(unit):
	if unit:
		active_unit_label.set_text("Active unit: %s" % unit.name)
	else:
		active_unit_label.set_text("Active unit: %s" % "None")
