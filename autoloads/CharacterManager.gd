extends Node2D


var initialized := false

var character_dict = {
	"Alpha": {
		"data" : preload("res://resources/characters/Alpha.tres"), 
		"recruitable": true,
		"recruited": false,
		"active": false
		}, 
	"Beta": {
		"data": preload("res://resources/characters/Beta.tres"),
		"recruitable": true,
		"recruited": false,
		"active": false
		} 
}

var player_dict = {
	"player_name" : "Steebo", 
	"current_party": [],
	"available_party": [],
	"known_convictions" : {}
}


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	EventBus.connect("conviction_learned", self,"learn_conviction")
	print("CM: CharacterManager ready")
	pass # Replace with function body.
	
func initialize_player():
	if !initialized:
		print("CM: Initializing player")
		character_dict[player_dict.player_name] = {
			"data": preload("res://resources/characters/player.tres"),
			"recruitable": true,
			"recruited": true,
			"active": true
		}
		character_dict[player_dict.player_name].data.character_name = player_dict.player_name
		player_dict["current_party"].append(player_dict.player_name)
		for character in character_dict:
			if character == player_dict.player_name:
				continue
			if character_dict[character].recruited:
				add_to_roster(character)
			if character_dict[character].active:
				add_to_party(character)
		initialized = true

func learn_conviction(conviction : Conviction):
	print("CM: Attempting to learn conviction %s" % conviction.conviction_name)
	if !player_dict.known_convictions.has(conviction.conviction_name):
		var conviction_data = {
				"name": conviction.conviction_name, 
				"level": 1, 
				"xp": 0, 
			}
		var known_conviction = KnownConviction.new(conviction_data)
		player_dict.known_convictions[conviction.conviction_name] = known_conviction
		print("CM: Conviction learned %s" % known_conviction.conviction.conviction_name)
		EventBus.emit_signal("conviction_updated")
	else:
		print("CM: Conviction %s already known" % conviction.conviction_name)

func equip_conviction(conviction: Conviction, character: CharacterData):
	print ("CM: Equipping %s to %s" % [conviction.conviction_name, character.character_name])
	if !player_dict.known_convictions.has(conviction.conviction_name):
		learn_conviction(conviction)
	if !character.equipped_convictions.has(conviction.conviction_name) and !(character.equipped_convictions.size() >= character.max_equipped_convictions):
		character.equipped_convictions.append(conviction.conviction_name)
		EventBus.emit_signal("conviction_equipped", character.equipped_convictions)
		

func add_to_party(character):
	if !player_dict["available_party"].has(character):
		return
	print ("CM: Adding %s to party" % [character])
	character_dict[character].active = true
	player_dict["current_party"].append(character)
	var temp = player_dict["available_party"].find(character)
	player_dict["available_party"].pop_at(temp)
	pass

func add_to_roster(character):
	if !character_dict.has(character):
		return
	print ("CM: Adding %s to roster" % [character])
	character_dict[character].recruited = true
	player_dict["available_party"].append(character)
	if player_dict["current_party"].has(character):
		var temp = player_dict["current_party"].find(character)
		player_dict["current_party"].pop_at(temp)
	pass
