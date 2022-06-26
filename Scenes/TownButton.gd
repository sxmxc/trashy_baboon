extends TextureButton

onready var select_icon = $SelectIcon
onready var anim = $AnimationPlayer
onready var name_label = $Label

export (String) var town_name
export (bool) var hidden_town
export (Array,NodePath) var linked_towns


var _hovered = false


# Called when the node enters the scene tree for the first time.
func _ready():
	EventBus.connect("town_unlocked", self, "_on_town_unlocked")
	yield(get_parent().get_parent(), "ready")
	_refresh()

func _refresh():
	if !disabled:
		name_label.set_text(town_name)
		hint_tooltip = town_name
	else:
		name_label.set_text("")
		hint_tooltip = ""

func _on_town_unlocked():
	_refresh()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if _hovered and !disabled:
		select_icon.visible = true
	else:
		select_icon.visible = false
	pass


func _on_TownButton_mouse_entered():
	_hovered = true
	anim.play("icon_hover")
	pass # Replace with function body.


func _on_TownButton_mouse_exited():
	_hovered = false
	anim.stop()
	pass # Replace with function body.


func _on_TownButton_pressed():
	pass # Replace with function body.

func get_linked_towns() -> Array:
	var link_locations = []
	for node in linked_towns:
		if !get_node(node).disabled:
			link_locations.append(get_node(node).get_position())
	return link_locations
