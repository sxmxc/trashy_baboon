extends CanvasLayer

var pause_menu_open = false

onready var pause_menu = $PauseMenu

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pause_menu.set_visible(pause_menu_open)
	pass # Replace with function body.

func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		pause_menu_open = !pause_menu_open
		pause_menu.set_visible(pause_menu_open)
		get_tree().paused = pause_menu_open
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Resume_pressed():
	pause_menu_open = false
	pause_menu.set_visible(pause_menu_open)
	get_tree().paused = pause_menu_open
	


func _on_Exit_pressed():
	pause_menu_open = false
	pause_menu.set_visible(pause_menu_open)
	get_tree().paused = pause_menu_open
	EventBus.emit_signal("quit_requested")
	pass # Replace with function body.
