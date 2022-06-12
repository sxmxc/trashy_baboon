extends CanvasLayer

onready var active_unit_label = $ActiveUnitContainer/Vbox/ActiveUnitLabel
onready var health_label = $ActiveUnitContainer/Vbox/HealthLabel
onready var range_label = $ActiveUnitContainer/Vbox/RangeLabel
onready var speed_label = $ActiveUnitContainer/Vbox/SpeedLabel
onready var turn_queue_display = $TurnQueueContainer
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	EventBus.connect("active_unit_changed", self, "_on_active_unit_change")
	turn_queue_display.initialize()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _on_active_unit_change(unit: Unit):
	if unit:
		active_unit_label.set_text("Active unit: %s" % unit.character_name)
		health_label.set_text("Health: %d" % unit.stats.max_health)
		range_label.set_text("Range: %d" % unit.move_range)
		speed_label.set_text("Speed: %d" % unit.move_speed)
	else:
		active_unit_label.set_text("Active unit: %s" % "None")
