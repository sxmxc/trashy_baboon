extends CanvasLayer

onready var node_list = $VBoxContainer/NodeUnlock/NodeList

var town_to_unlock = -1

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func add_to_node_list(button: TextureButton):
	node_list.add_item(button.town_name)



func _on_NodeList_item_selected(index):
	town_to_unlock = index
	pass # Replace with function body.


func _on_Button_pressed():
	if town_to_unlock != -1:
		get_parent().unlock_town_index(town_to_unlock)
	pass # Replace with function body.
