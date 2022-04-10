extends CanvasLayer

onready var map_title = $MapTitle
onready var player_menu = $PlayerMenu
onready var system_menu = $SystemMenu




# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	EventBus.connect("map_changed", self, "_on_map_changed")
	set_process(true)
	pass # Replace with function body.

func _process(_delta):
	get_gui_input()
	
func get_gui_input():
	if Input.is_action_just_pressed("player_menu"):
		menu_requested()
	if Input.is_action_just_pressed("system_menu"):
		system_menu_requested()
		
func _on_map_changed(map):
	map_title.text = map.name

func menu_requested():
	player_menu.visible = !player_menu.visible
	if player_menu.visible:
		EventBus.emit_signal("menu_opened")
		get_tree().paused = true
	else:
		EventBus.emit_signal("menu_closed")
		get_tree().paused = false

func system_menu_requested():
	system_menu.visible = !system_menu.visible
	if system_menu.visible:
		EventBus.emit_signal("system_menu_opened")
		get_tree().paused = true
	else:
		EventBus.emit_signal("system_menu_closed")
		get_tree().paused = false

func _on_QuitButton_pressed():
	get_tree().paused = false
	EventBus.emit_signal("quit_requested")
	pass # Replace with function body.
