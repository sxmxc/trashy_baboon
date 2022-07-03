extends Panel
onready var party_button = $PartyMemberButton as TextureButton
var party_member_name


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func set_data(data: CharacterData):
	party_button.texture_normal = data.char_portrait
	party_member_name = data.character_name
	party_button.connect("pressed", self, "_on_PartyMemberButton_pressed", [party_member_name])
	
	

func _on_PartyMemberButton_pressed(member):
	print("Member button %s clicked" % member)
	EventBus.emit_signal("party_tab_member_selected", member)
	pass # Replace with function body.
