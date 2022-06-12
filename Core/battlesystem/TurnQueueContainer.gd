extends MarginContainer

onready var queue_display = $Hbox/Queuebox
onready var active_char_display = $Hbox/ActiveCharacter/TextureRect

func initialize():
	pass
# Called when the node enters the scene tree for the first time.
func _ready():
	EventBus.connect("battle_queue_updated", self, "_populate_queue")
	EventBus.connect("active_unit_changed", self, "_on_active_unit_changed")
	pass # Replace with function body.

func _clear_queue():
	for child in queue_display.get_children():
		child.queue_free()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_active_unit_changed(unit: Unit):
	if unit:
		active_char_display.set_texture(unit.character_data.char_portrait)

func _populate_queue(units : Array):
	_clear_queue()
	active_char_display.set_texture(units[0].character_data.char_portrait)
	for unit in units:
		var textureRect = TextureRect.new()
		textureRect.set_texture(unit.character_data.char_portrait)
		queue_display.add_child(textureRect)
