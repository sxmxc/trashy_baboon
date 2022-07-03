extends Tabs

signal conviction_selected

onready var conviction_list = $HBoxContainer/ConvictionLeftPanel/ConvictionLeft/ConvictionList as ItemList
onready var conviction_name_label = $HBoxContainer/ConvictionRightPanel/ConvictionDetails/ConvictionDetailPanel/VBoxContainer/DetailName/Value
onready var conviction_detail_label = $HBoxContainer/ConvictionRightPanel/ConvictionDetails/ConvictionDetailPanel/VBoxContainer/HBoxContainer/DetailBody
onready var convictioni_action_label = $HBoxContainer/ConvictionRightPanel/ConvictionDetails/ConvictionDetailPanel/VBoxContainer/DetailAction/Value
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	conviction_list.select(0)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_ConvictionList_item_selected(index):
	var item_name = conviction_list.get_item_text(index)
	print("Conviction selected %s" %  item_name)
	if Global.conviction_dictionary.has(item_name):
		conviction_name_label.set_text(item_name)
		conviction_detail_label.set_text(Global.conviction_dictionary[item_name].conviction_description)
		convictioni_action_label.set_text(Global.conviction_dictionary[item_name].conviction_battle_ability.ability_name)
	pass # Replace with function body.


func _on_ConvictionList_item_activated(index):
	pass # Replace with function body.
