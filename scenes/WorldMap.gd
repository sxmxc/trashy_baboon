extends Node2D

onready var map = $Map
onready var character = $Map/Character
var town_buttons = []

export (String) var world_name 


# Called when the node enters the scene tree for the first time.
func _ready():
	$WorldMapGUI/MapName.text = world_name
	for child in $Towns.get_children():
		child.connect("pressed", self, "_on_town_button_pressed", [child])
		town_buttons.append(child)
		$DevGUI.add_to_node_list(child)
	EventBus.connect("town_unlocked", self, "update")
	EventBus.connect("hidden_town_unlocked", self, "_on_hidden_town_unlocked")
	initialize()
	pass # Replace with function body.


func initialize():
	character.position = get_middle($Towns.get_child(Global.player_town_idx).get_position(), $Towns.get_child(Global.player_town_idx).rect_size)
	for unlock in Global.player_towns_unlocked:
		if unlock <= $Towns.get_child_count() and !$Towns.get_child(unlock).hidden_town:
			$Towns.get_child(unlock).disabled = false
	for town_name in Global.hidden_towns:
		if Global.hidden_towns[town_name].unlocked:
			$Towns.get_child(Global.hidden_towns[town_name].index).disabled = false
	update()
	
func _draw():
	for child in $Towns.get_children():
		for node in child.get_linked_towns():
			draw_line(get_middle(child.get_position(), child.rect_size), get_middle(node, child.rect_size), Color(255, 0, 0), 3)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
#	map_path_follow.unit_offset += .1 * delta
	if Input.is_action_just_pressed("debug_unlock_level"):
		unlock_town()
	elif Input.is_action_just_pressed("debug_lock_level"):
		lock_town()
	pass
	
func _move_character(start_position, target_postion):
	map.update_navigation_path(start_position, target_postion)


func _on_town_button_pressed(button: TextureButton):
	if Global.player_town_idx == button.get_index():
		SceneManager.change_scene(Global.town_dict[button.get_index()])
		return
	_move_character(character.position, get_middle(button.get_position(), button.rect_size))
	Global.player_town_idx = button.get_index()

func _on_hidden_town_unlocked(name):
	if Global.hidden_towns.has(name):
			Global.hidden_towns[name].unlocked = true
			unlock_town_index(Global.hidden_towns[name].index)
			EventBus.emit_signal("town_unlocked")

func unlock_town_index(idx):
	Global.player_towns_unlocked = idx + 1
	for town in Global.hidden_towns:
		if Global.hidden_towns[town].index == idx:
			Global.hidden_towns[town].unlocked = true
	$Towns.get_child(idx).disabled = false
	EventBus.emit_signal("town_unlocked")

func unlock_town():
	Global.player_towns_unlocked += 1
	if Global.player_towns_unlocked > $Towns.get_child_count():
		Global.player_towns_unlocked = $Towns.get_child_count()
	$Towns.get_child(Global.player_towns_unlocked - 1).disabled = false
	EventBus.emit_signal("town_unlocked")

func lock_town():
	Global.player_towns_unlocked -= 1
	if Global.player_towns_unlocked < 0:
		Global.player_towns_unlocked = 0
		return
	$Towns.get_child(Global.player_towns_unlocked).disabled = true
	EventBus.emit_signal("town_unlocked")

func get_middle(position: Vector2, size: Vector2) -> Vector2:
	return Vector2(position.x + size.x/2, position.y + size.y/2)


func _on_Button_pressed():
	EventBus.emit_signal("hidden_town_unlocked", "Hidden Village")
	pass # Replace with function body.


func _on_Button2_pressed():
	EventBus.emit_signal("hidden_town_unlocked", "Hidden Caves")
	pass # Replace with function body.
