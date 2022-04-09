extends KinematicBody2D

export(Resource) var character

onready var sprite = $Sprite
onready var dialog_prompt = $PopupPanel
onready var popup_position = $Position2D
var player_in_range = false

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_player_interaction_pressed(member_name):
	print_debug("WorldNPC received player interaction signal")
	if player_in_range:
		Dialogic.set_variable('player_name', member_name)
		print_debug("%s talking to %s" %[member_name, character.name])
		var timeline = character.dialog_timelines[0]
		var new_dialog = Dialogic.start(timeline)
		new_dialog.connect("timeline_end", self, "_on_timeline_end")
		add_child(new_dialog)
		EventBus.emit_signal("dialog_starting")

func _on_DialogProximity_body_entered(body):
	var label = Label.new()
	label.text = "(E) Talk"
	dialog_prompt.add_child(label)
	dialog_prompt.rect_position = popup_position.global_position
	dialog_prompt.popup()
	player_in_range = true
	pass # Replace with function body.

func _on_timeline_end(timeline):
	EventBus.emit_signal("dialog_ended", Dialogic.get_variable("survival_gain") as int, Dialogic.get_variable("strength_gain") as int, Dialogic.get_variable("peace_gain") as int)

func _on_DialogProximity_body_exited(body):
	player_in_range = false
	dialog_prompt.hide()
	for child in dialog_prompt.get_children():
		child.queue_free()
	pass # Replace with function body.
