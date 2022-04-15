extends TileMap
class_name Grid


enum {PLAYER, NPC, OBSTACLE}

enum Elevation {FULL, HALF, QUARTER, EIGHTH}

var tile_size = get_cell_size()

# The map_to_world function returns the position of the tile's top left corner in isometric space,
# we have to offset the objects on the Y axis to center them on the tiles

export (Dictionary) var offset_dict = {
	Elevation.FULL: Vector2(0,0),
	Elevation.HALF: Vector2(0,8),
	Elevation.QUARTER: Vector2(0,10), 
	Elevation.EIGHTH: Vector2(0,14)
}

export (Dictionary) var atlas_elevations = {
	Vector2(0,0) : Elevation.FULL, 
	Vector2(1,0) : Elevation.HALF, 
	Vector2(0,1) : Elevation.QUARTER,
	Vector2(1,1) : Elevation.EIGHTH
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
	for cell in get_used_cells():
		if cell.x < grid_size.x and cell.x >= 0:
			if cell.y < grid_size.y and cell.y >= 0:
				var atlas_coord = get_cell_autotile_coord(cell.x, cell.y)
				if atlas_elevations.has(atlas_coord):
					grid[cell.x][cell.y].elevation = atlas_elevations[atlas_coord]

func _input(event):
	var tile_atlas_id = Vector2.ZERO
	if event is InputEventMouseButton:
		var grid_position = world_to_map(get_local_mouse_position())
		print("Mouse click at grid: %s " % grid_position)
	elif event is InputEventMouseMotion:
		var grid_position = world_to_map(get_local_mouse_position())
		var world_position = map_to_world(grid_position)
		tile_atlas_id = get_cell_autotile_coord(grid_position.x, grid_position.y)
		if grid_position !=  prev_mouse_grid_pos:
			if grid_position.x < grid_size.x and grid_position.x >= 0:
				if grid_position.y < grid_size.y and grid_position.y >= 0:
					var tile_offset = offset_dict[grid[grid_position.x][grid_position.y].elevation]
					EventBus.emit_signal("mouse_grid_position_updated", grid_position, world_position, tile_offset, tile_atlas_id)
#			print("Mouse moved to grid: %s " % grid_position)

func set_player(value):
	if value:
		var tile_offset = Vector2()
		player = value
		player.register_tilemap(self)
		var battle_positions = get_tree().get_nodes_in_group("spawn_point")
		if battle_positions:
			var world_pos = battle_positions[0].position
			var grid_pos = world_to_map(world_pos)
			tile_offset = get_cell_offset(grid_pos)
			player.position = map_to_world(grid_pos) + tile_offset
			grid[grid_pos.x][grid_pos.y].contents = player.type
			print("Player pos %s, Elevation %s" % [grid_pos, grid[grid_pos.x][grid_pos.y].elevation])
			EventBus.emit_signal("player_grid_position_updated", grid_pos, tile_offset)
			return
		#no spawn point so set player at a default location
		print("Now spawn point found. Setting player to (12,10)")
		tile_offset = get_cell_offset(Vector2(12,10))
		player.position = (map_to_world(Vector2(12,10)) + tile_offset)
		grid[12][10].content = player.type
		tile_offset = offset_dict[grid[12][10].elevation]
		EventBus.emit_signal("player_grid_position_updated", Vector2(12,10), tile_offset)

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

func get_cell_offset(grid_pos=Vector2()):
	if grid_pos.x < grid_size.x and grid_pos.x >= 0:
		if grid_pos.y < grid_size.y and grid_pos.y >= 0:
			return offset_dict[get_cell_elevation(grid_pos)]
	return Vector2.ZERO

func get_cell_offsetv(pos=Vector2()):
	var grid_pos = world_to_map(pos)
	if grid_pos.x < grid_size.x and grid_pos.x >= 0:
		if grid_pos.y < grid_size.y and grid_pos.y >= 0:
			return offset_dict[get_cell_elevation(grid_pos)]
	return Vector2.ZERO

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
	var tile_offset = get_cell_offset(new_grid_pos)
	var target_pos = map_to_world(new_grid_pos) + tile_offset
	#Debug stuffs
	print("\nPos %s, dir %s" % [pos, direction])
	print("Grid pos, old: %s, new: %s" % [grid_pos, new_grid_pos])
	print("Target pos: %s, Offset %s" % [target_pos, tile_offset])
	EventBus.emit_signal("player_grid_position_updated", new_grid_pos, tile_offset)
	return target_pos
	
func is_cell_of_type(pos=Vector2(), type=null):
	var grid_pos = world_to_map(pos)
	return true if grid[grid_pos.x][grid_pos.y].content == type else false

func get_cell_global_position(glo_position: Vector2) -> Vector2:
	return to_global(map_to_world(world_to_map(to_local(glo_position))))
