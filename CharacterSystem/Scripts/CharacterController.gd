extends Node2D
class_name CharacterController

signal member_name_updated(new_name)
signal member_added(member_node)
signal active_members_updated
signal member_conviction_updated(member_name)
signal lead_member_changed(member_name)

export (Dictionary) var party_roster
export (Dictionary) var known_convictions

export var max_party_size := 6

export (String) var active_member_name
export (Resource) var active_member_node

onready var party_members = $PartyMembers


# Called when the node enters the scene tree for the first time.
func _ready():
	#this is to pass the conviction buffs or debuffs. need to possibly figure out better way
	EventBus.connect("cutscene_ended", self, "_on_dialog_ended")
	pass # Replace with function body.
	
func change_name(member, value: String):
	var old = member.name
	var new = value
	party_roster[new] = party_roster[old]
	party_roster[new].member.name = new
	party_roster[new].node.name = new
	party_roster[new].node.display_name = new
	party_roster.erase(old)
	emit_signal("member_name_updated", new)

func add_member(member, set_active:=false):
	var member_node = party_members.add_member(member)
	party_roster[member.name] = {"member": member, "party_active": set_active, "node": member_node}
	emit_signal("member_added")
	
func set_party_active(member_name: String, value:= false):
	party_roster[member_name].party_active = value
	emit_signal("active_members_updated")

func toggle_party_active(member_name: String):
	party_roster[member_name].party_active = !party_roster[member_name].party_active
	emit_signal("active_members_updated")

func equip_conviction(member_name: String, conv: Conviction):
	party_roster[member_name].member.equipped_convictions[conv.name] = conv
	update_known_convictions()	
	emit_signal("member_conviction_updated", member_name)
	
func set_active_member(member_name: String):
	if party_roster.has(member_name):
		active_member_name = member_name
		active_member_node = party_roster[member_name].node
		emit_signal("lead_member_changed", member_name)

func update_known_convictions():
	for member in party_roster:
		for conviction in party_roster[member].node.convictions:
			if !known_convictions.has(conviction):
				known_convictions[conviction] = {"name": conviction, "owner": member}

func _on_dialog_ended(survival, strength, peace):
	#this is to pass the conviction buffs or debuffs. need to figure out better way
	if survival > 0:
		party_roster[active_member_name].node.add_conviction_experience("Survival", survival)
	if strength > 0:
		party_roster[active_member_name].node.add_conviction_experience("Strength", strength)
	if peace > 0:
		party_roster[active_member_name].node.add_conviction_experience("Peace", peace)
	pass
