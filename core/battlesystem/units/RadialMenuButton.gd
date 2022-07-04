extends TextureButton


export var radius = 120
export var speed = 0.25

export (PackedScene) var action_option_scene = preload("res://core/battlesystem/units/ActionOption.tscn")

signal action_pressed

var num
var active = false

func _ready():
	self.connect("pressed", self, "_on_ActionMenu_pressed", [get_parent().get_parent()])
	initialize()

func initialize():
	print("Radial initiliazing")
	$Buttons.hide()
	num = $Buttons.get_child_count()
	for b in $Buttons.get_children():
		b.set_position(get_position())

func add_actions(actions: Array):
	for b in $Buttons.get_children():
		if b.name != "EndTurn":
			b.free()
		elif !b.is_connected("pressed", self, "_on_option_pressed"):
			b.connect("pressed", self, "_on_option_pressed",[b])
	if actions != []:
		for action in actions:
			print("Radial add actions: %s" % action)
			var action_option = action_option_scene.instance()
			action_option.option_display = action.ability_description
			action_option.option_icon = action.ability_icon as Texture
			action_option.option_action = action.ability_name
			action_option.connect("pressed", self, "_on_option_pressed",[action_option])
			$Buttons.add_child(action_option)
		initialize()


func _on_Tween_tween_all_completed():
	disabled = false
	active = not active
	if not active:
		$Buttons.hide()

func _on_option_pressed(option):
	hide_menu()
	emit_signal("action_pressed", option.option_action)

func _on_ActionMenu_pressed(unit):
	disabled = true
	if active:
		hide_menu()
	else:
		show_menu(unit.current_action_points)
	pass # Replace with function body.


func show_menu(action_points):
	var spacing = TAU / num
	for b in $Buttons.get_children():
		if action_points <= 0 and b.name != "EndTurn":
			b.disabled = true
		else:
			b.disabled = false
		# Subtract PI/2 to align the first button  to the top
		var a = spacing * b.get_index() - PI / 2
		var dest = b.rect_position + Vector2(radius, 0).rotated(a)
		$Tween.interpolate_property(b, "rect_position",
				b.rect_position, dest, speed,
				Tween.TRANS_BACK, Tween.EASE_OUT)
		$Tween.interpolate_property(b, "rect_scale",
				Vector2(0.5, 0.5), Vector2.ONE, speed,
				Tween.TRANS_LINEAR)
	$Buttons.show()
	$Tween.start()
	
	
func hide_menu():
	for b in $Buttons.get_children():
		$Tween.interpolate_property(b, "rect_position", b.rect_position,
				rect_position, speed, Tween.TRANS_BACK, Tween.EASE_IN)
		$Tween.interpolate_property(b, "rect_scale", null,
				Vector2(0.5, 0.5), speed, Tween.TRANS_LINEAR)
	$Tween.start()
