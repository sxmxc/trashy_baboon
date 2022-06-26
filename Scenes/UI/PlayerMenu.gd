extends Panel

onready var book_anim = $HBoxContainer/AnimatedSprite/AnimationPlayer as AnimationPlayer
onready var tab_container = $HBoxContainer/TabContainer as TabContainer

var previous_tab_index : int

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	
	for child in $HBoxContainer/VBoxContainer.get_children():
		child.connect("focus_entered", self, "_on_Button_focus_entered", [child])
		child.connect("pressed", self, "_on_Button_pressed", [child])
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Button_pressed(button : Button):
	var button_idx = button.get_index()
	var current_tab = tab_container.current_tab
	previous_tab_index = current_tab
	if button.disabled or current_tab == button_idx:
		return
	if previous_tab_index > button_idx:
		book_anim.play("turn_page_rtl")
	else:
		book_anim.play("turn_page_ltr")
	tab_container.current_tab = button_idx
	
	
	

func _on_Button_focus_entered(button: Button): 
#	if button.disabled:
#		return
#	tab_container.current_tab = button.get_index()
#	book_anim.play("turn_page")
	pass # Replace with function body.


