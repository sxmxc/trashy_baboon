extends CanvasLayer


onready var selected_cell_label = $VBoxContainer/SelectedCellLabel
onready var mouse_pos_label = $VBoxContainer/MousePositionLabel
onready var mouse_global_labal = $VBoxContainer/MouseGlobalLabel
onready var character_list = $VBoxContainer/HBoxContainer/Characters as OptionButton
onready var conviction_list = $VBoxContainer/HBoxContainer/Convictions as OptionButton
onready var character_list2 = $VBoxContainer/HBoxContainer2/Characters as OptionButton
onready var conviction_list2 = $VBoxContainer/HBoxContainer2/Convictions as OptionButton
onready var conviction_set_button = $VBoxContainer/HBoxContainer/Button
onready var conviction_equip_button = $VBoxContainer/HBoxContainer2/Button


# Called when the node enters the scene tree for the first time.
func _ready():
	EventBus.connect("cursor_moved", self, "_on_cursor_moved")
	EventBus.connect("cell_selected",self,"_on_cell_selected")
	conviction_set_button.connect("pressed", self,"_on_learn_conviction")
	conviction_equip_button.connect("pressed", self,"_on_equip_conviction")
	yield(EventBus, "battle_scene_ready")
	for character in CharacterManager.player_dict.current_party:
		character_list.add_item(character)
		character_list2.add_item(character)
	for conviction in Global.conviction_dictionary:
		conviction_list.add_item(conviction)
		conviction_list2.add_item(conviction)
	pass # Replace with function body.


func _on_cursor_moved(new_cell):
	selected_cell_label.set_text("Selected Cell: x %d y %d" % [new_cell.x,new_cell.y])
	
func _input(event):
	if event is InputEventMouseMotion:
		mouse_pos_label.set_text("Mouse Position: x %d y %d" % [event.position.x, event.position.y])
		mouse_global_labal.set_text("Mouse Global: x %d y %d" % [owner.get_global_mouse_position().x, owner.get_global_mouse_position().y])
			
func _on_cell_selected(cell):
	print("Cell clicked: %s" % cell)

func _on_learn_conviction():
	var character = character_list.get_item_text(character_list.get_selected_id())
	var conviction = conviction_list.get_item_text(conviction_list.get_selected_id())
	CharacterManager.learn_conviction(Global.conviction_dictionary[conviction])
	print("DEV: %s learned %s" % [character, conviction])
	pass

func _on_equip_conviction():
	var character = character_list2.get_item_text(character_list2.get_selected_id())
	var conviction = conviction_list2.get_item_text(conviction_list2.get_selected_id())
	CharacterManager.equip_conviction(Global.conviction_dictionary[conviction], CharacterManager.character_dict[character].data)
	print("DEV: %s equipped %s" % [character, conviction])
	pass
