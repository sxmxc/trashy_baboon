extends Panel

onready var name_value = $MarginContainer/VBoxContainer/NameContainer/Value
onready var health_value = $MarginContainer/VBoxContainer/HealthContainer/Value
onready var speed_value = $MarginContainer/VBoxContainer/SpeedContainer/Value
onready var ap_value = $MarginContainer/VBoxContainer/ActionPointsContainer/Value
onready var equipped_conviction_list = $MarginContainer/VBoxContainer/EquippedConvictionsContainer/ItemList as ItemList
onready var available_conviction_list = $MarginContainer/VBoxContainer/AvailableConvictionsContainer/ItemList as ItemList

var selected_member
# Called when the node enters the scene tree for the first time.
func _ready():
	EventBus.connect("party_tab_member_selected", self, "_on_party_member_selected")
	EventBus.connect("conviction_updated", self, "_on_convictions_updated" )
	EventBus.connect("conviction_equipped", self, "_update_equipped")
	equipped_conviction_list.clear()
	available_conviction_list.clear()	
	pass # Replace with function body.


func _on_party_member_selected(member_name):
	selected_member = member_name
	name_value.set_text(member_name)
	health_value.set_text("%s" % CharacterManager.character_dict[member_name].data.base_health_max)
	speed_value.set_text("%s" % CharacterManager.character_dict[member_name].data.base_speed)
	ap_value.set_text("%s" % CharacterManager.character_dict[member_name].data.base_action_points)
	equipped_conviction_list.clear()
	available_conviction_list.clear()
	for conviction in CharacterManager.character_dict[member_name].data.equipped_convictions:
		equipped_conviction_list.add_item("%s lvl %s" % [conviction,CharacterManager.player_dict.known_convictions[conviction].conviction_level])
	for conviction in CharacterManager.player_dict.known_convictions:
		available_conviction_list.add_item("%s" % [conviction])

func _update_equipped(convictions):
	for conviction in convictions:
		equipped_conviction_list.clear()
		equipped_conviction_list.add_item("%s lvl %s" % [conviction,CharacterManager.player_dict.known_convictions[conviction].conviction_level])

func _on_convictions_updated():
	pass


func _on_RightPanel_visibility_changed():
	_on_party_member_selected(CharacterManager.player_dict.current_party[0])
	pass # Replace with function body.


func _on_ItemList_item_selected(index):
	pass # Replace with function body.


func _on_ItemList_item_activated(index):
	var conviction = Global.conviction_dictionary[available_conviction_list.get_item_text(index)] as Conviction
	CharacterManager.equip_conviction(conviction, CharacterManager.character_dict[selected_member].data)
	pass # Replace with function body.
