extends Node2D
class_name CharacterController

export (Dictionary) var party_roster

export var max_party_size := 6

export (Resource) var active_member


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func change_name(member:Member, value: String):
	var old = member.name
	var new = value
	party_roster[new] = party_roster[old]
	party_roster[new].member.name = new
	party_roster.erase(old)

func add_member(member: Member, set_active:=false):
	party_roster[member.name] = {"member": member, "party_active": set_active}
	
func set_party_active(member_name: String, value:= false):
	party_roster[member_name].party_active = value

func toggle_party_active(member_name: String):
	party_roster[member_name].party_active = !party_roster[member_name].party_active

func equip_conviction(member_name: String, conv: Conviction):
	party_roster[member_name].member.equipped_convictions[conv.name] = conv
	
func set_active_member(member_name: String):
	if party_roster.has(member_name):
		active_member = party_roster[member_name].member
