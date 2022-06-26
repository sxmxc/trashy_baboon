extends TextureButton


export var radius = 120
export var speed = 0.25

signal action_pressed

var num
var active = false

func _ready():
	$Buttons.hide()
	num = $Buttons.get_child_count()
	for b in $Buttons.get_children():
		b.set_position(get_position())


func _on_Move_pressed():
	hide_menu()
	emit_signal("action_pressed", "move")
	pass # Replace with function body.


func _on_Tween_tween_all_completed():
	disabled = false
	active = not active
	if not active:
		$Buttons.hide()


func _on_ActionMenu_pressed():
	disabled = true
	if active:
		hide_menu()
	else:
		show_menu()
	pass # Replace with function body.


func show_menu():
	var spacing = TAU / num
	for b in $Buttons.get_children():
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


func _on_EndTurn_pressed():
	emit_signal("action_pressed", "end_turn")
	pass # Replace with function body.


func _on_Peace_pressed():
	pass # Replace with function body.
