extends TownMap


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func _ready():
#	Dialogic.set_variable('player_name', Global.player_dict.player_name)
#	var dialog = Dialogic.start("intro_2")
#	dialog_ui.add_child(dialog)
	if !player:
		player = $TileMap/YSort/Player
	tile_map.set_player(player)
	var npcs = get_tree().get_nodes_in_group("npc")
	for npc in npcs:
		tile_map.register_entity(npc.position, Grid.OBSTACLE)
		if player:
			EventBus.connect("interaction_pressed", npc, "_on_player_interaction_pressed")
	player_ui.initialize(player)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
