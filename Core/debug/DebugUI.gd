extends CanvasLayer


onready var selected_cell_label = $VBoxContainer/SelectedCellLabel
onready var mouse_pos_label = $VBoxContainer/MousePositionLabel
onready var mouse_global_labal = $VBoxContainer/MouseGlobalLabel


# Called when the node enters the scene tree for the first time.
func _ready():
	EventBus.connect("cursor_moved", self, "_on_cursor_moved")
	EventBus.connect("cell_selected",self,"_on_cell_selected")
	pass # Replace with function body.


func _on_cursor_moved(new_cell):
	selected_cell_label.set_text("Selected Cell: x %d y %d" % [new_cell.x,new_cell.y])
	
func _input(event):
	if event is InputEventMouseMotion:
		mouse_pos_label.set_text("Mouse Position: x %d y %d" % [event.position.x, event.position.y])
		mouse_global_labal.set_text("Mouse Global: x %d y %d" % [owner.get_global_mouse_position().x, owner.get_global_mouse_position().y])

func _on_cell_selected(cell):
	print("Cell clicked: %s" % cell)
