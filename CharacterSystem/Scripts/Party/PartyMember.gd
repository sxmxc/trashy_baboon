extends WorldMember
class_name PartyMember



func _ready():
	pass # Replace with function body.

func initialize(base_char: Character):
	.initialize(base_char)
	pass
	
func get_conviction_experience(conviction_name) -> int :
	return .get_conviction_experience(conviction_name)
	
func add_conviction_experience(conviction_name, amount):
	.add_conviction_experience(conviction_name, amount)
			
func get_conviction_level(conviction_name) -> int :
	return .get_conviction_level(conviction_name)
