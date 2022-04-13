extends TileMap
class_name Grid


enum {PLAYER, NPC, OBSTACLE}

enum Elevation {FULL, HALF, QUARTER, EIGHTH}

var tile_size = get_cell_size()

# The map_to_world function returns the position of the tile's top left corner in isometric space,
# we have to offset the objects on the Y axis to center them on the tiles
#var tile_offset = Vector2(0, tile_size.y / 2)
var tile_offset = Vector2.ZERO

export (Dictionary) var offset_dict = {
	Elevation.FULL: Vector2.ZERO,
	Elevation.HALF: Vector2(0,8),
	Elevation.QUARTER: Vector2(0,4), 
	Elevation.EIGHTH: Vector2(0,2)
}

var grid_size = Vector2(128, 128)

var grid = []

var prev_mouse_grid_pos = Vector2.ZERO

onready var player
# We need to add the Player and Obstacles as children of the YSort node so when the player is below
# an obstacle on the screen Y axis, he'll be drawn above it
onready var sorter = get_child(0)


func _ready():
	for x in range(grid_size.x):
		grid.append([])
		for _y in range(grid_size.y):
			grid[x].append({"content": null, "elevation": Elevation.FULL})

func _input(event):
   # Mouse in viewport coordinates.
	if event is InputEventMouseButton:
		var grid_position = world_to_map(get_local_mouse_position())
		print("Mouse click at grid: %s " % grid_position)
	elif event is InputEventMouseMotion:
		var grid_position = world_to_map(get_local_mouse_position())
		var world_position = map_to_world(grid_position)
		if grid_position !=  prev_mouse_grid_pos:
			tile_offset = offset_dict[grid[grid_position.x][grid_position.y].elevation]
			EventBus.emit_signal("mouse_grid_position_updated", grid_position, world_position, tile_offset)
#			print("Mouse moved to grid: %s " % grid_position)

func set_player(value):
	if value:			
		player = value
		player.register_tilemap(self)
		var battle_positions = get_tree().get_nodes_in_group("battle_position")
		if battle_positions:
			var world_pos = battle_positions[0].position
			var grid_pos = world_to_map(world_pos)
			player.position = map_to_world(grid_pos)
			grid[grid_pos.x][grid_pos.y].contents = player.type
			print("Player pos %s" % [grid_pos])
			EventBus.emit_signal("player_grid_position_updated", grid_pos)
			return
		player.position = (map_to_world(Vector2(12,10)))
		grid[12][10].content = player.type
		EventBus.emit_signal("player_grid_position_updated", Vector2(12,10))

func register_entity(pos, type):
	if is_cell_vacant(pos):
		var grid_pos = (world_to_map(pos))
		grid[grid_pos.x][grid_pos.y].content = type
		
func get_cell_content(pos=Vector2()):
	return grid[pos.x][pos.y].content

func get_cell_elevation(pos=Vector2()):
	return grid[pos.x][pos.y].elevation

func get_cell_tile_id(pos=Vector2()):
	return get_cellv(pos)


func is_cell_vacant(pos=Vector2(), direction=Vector2()):
	var grid_pos = world_to_map(pos) + direction
	if grid_pos.x < grid_size.x and grid_pos.x >= 0:
		if grid_pos.y < grid_size.y and grid_pos.y >= 0:
			return true if grid[grid_pos.x][grid_pos.y].content == null else false
	return false


func update_child_pos(pos, direction, type):
	var grid_pos = world_to_map(pos)
	grid[grid_pos.x][grid_pos.y].content = null

	var new_grid_pos = grid_pos + direction
	grid[new_grid_pos.x][new_grid_pos.y].content = type

	var target_pos = map_to_world(new_grid_pos)

	# Print statements help to understand what's happening. We're using GDscript's string format operator % to convert
	# Vector2s to strings and integrate them to a sentence. The syntax is "... %s" % value / "... %s ... %s" % [value_1, value_2]
	print("\nPos %s, dir %s" % [pos, direction])
	print("Grid pos, old: %s, new: %s" % [grid_pos, new_grid_pos])
	print("Current pos: %s" % target_pos)
	EventBus.emit_signal("player_grid_position_updated", new_grid_pos)
	return target_pos
	
func is_cell_of_type(pos=Vector2(), type=null):
	var grid_pos = world_to_map(pos)
	return true if grid[grid_pos.x][grid_pos.y].content == type else false

func get_cell_global_position(glo_position: Vector2) -> Vector2:
	return to_global(map_to_world(world_to_map(to_local(glo_position))))
