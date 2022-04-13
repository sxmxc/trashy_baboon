extends CanvasLayer

onready var map_title = $MapTitle
onready var player_menu = $PlayerMenu
onready var system_menu = $SystemMenu
onready var active_char_portrait = $ActiveCharPort/PortImage
onready var active_char_name = $ActiveCharPort/PortName
onready var active_char_hp = $StatBars/HBoxContainer/HP
onready var active_char_mp = $StatBars/HBoxContainer2/MP



# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	EventBus.connect("map_changed", self, "_on_map_changed")
	EventBus.connect("lead_member_changed", self, "_on_lead_member_changed")
	set_process(true)
	pass # Replace with function body.

func initialize(player):
	active_char_portrait.texture = player.active_member_node.character.char_portrait
	active_char_name.text = player.active_member_name
	active_char_hp.max_value = player.active_member_node.max_hp
	active_char_hp.value = player.active_member_node.hp
	active_char_mp.max_value = player.active_member_node.max_hp
	active_char_mp.value = player.active_member_node.mp

func _process(_delta):
	get_gui_input()
	
func get_gui_input():
	if Input.is_action_just_pressed("player_menu"):
		menu_requested()
	if Input.is_action_just_pressed("system_menu"):
		system_menu_requested()
		
func _on_map_changed(map):
	map_title.text = map.name

func _on_lead_member_changed(member_node):
	print("Lead member change signal received. New leader: %s" % member_node.display_name)
	active_char_portrait.texture = member_node.character.char_portrait
	active_char_name.text = member_node.display_name
	active_char_hp.max_value = member_node.max_hp
	active_char_hp.value = member_node.hp
	active_char_mp.max_value = member_node.max_hp
	active_char_mp.value = member_node.mp

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
