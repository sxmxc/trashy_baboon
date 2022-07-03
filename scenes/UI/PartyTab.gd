extends Tabs

onready var active_members = $HBoxContainer/LeftPanel/LeftVBox/ActivePartyVBox/CenterContainer/ActivePartyGrid
onready var available_members = $HBoxContainer/LeftPanel/LeftVBox/AvailablePartyVBox/CenterContainer/AvailablePartyGrid



# Called when the node enters the scene tree for the first time.
func _ready():
	active_members.initialize()
	available_members.initialize()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func clear_grids():
	for active in active_members.get_children():
		active.queue_free()
	for available in available_members.get_children():
		available.queue_free()
	
