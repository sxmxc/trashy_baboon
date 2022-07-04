extends Panel

onready var action_panel_grid = $LeftVBox/ActionMenu/GridContainer

var selected_member = null

# Called when the node enters the scene tree for the first time.
func _ready():
	EventBus.connect("party_tab_member_selected", self, "_on_party_member_selected")
	pass # Replace with function body.

func _process(_delta):
	if !selected_member:
		action_panel_grid.visible = false
	else:
		action_panel_grid.visible = true

func _on_party_member_selected(member):
	selected_member = member


func _on_MembershipButton_pressed():
	if CharacterManager.character_dict[selected_member].active:
		CharacterManager.character_dict[selected_member].active = false
		CharacterManager.add_to_roster(selected_member)
		EventBus.emit_signal("roster_updated")
	else:
		CharacterManager.character_dict[selected_member].active = true
		CharacterManager.add_to_party(selected_member)
		EventBus.emit_signal("roster_updated")
	pass # Replace with function body.
