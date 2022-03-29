extends Node
class_name PartyController

signal member_added(member)

export (PackedScene) var party_member_scene

func _ready():
	pass # Replace with function body.
	
func add_member(base: Character) -> Node:
	var party_mem = party_member_scene.instance()
	party_mem.initialize(base)
	party_mem.name = party_mem.display_name
	add_child(party_mem)
	emit_signal("member_added", party_mem)
	return party_mem

func remove_member():
	pass
