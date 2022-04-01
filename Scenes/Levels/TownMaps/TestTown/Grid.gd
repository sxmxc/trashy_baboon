extends TileMap


var tile_size = get_cell_size()
# The map_to_world function returns the position of the tile's top left corner in isometric space,
# we have to offset the objects on the Y axis to center them on the tiles
var tile_offset = Vector2(0, tile_size.y / 2)

var grid_size = Vector2(32, 32)

var grid = []

onready var player
# We need to add the Player and Obstacles as children of the YSort node so when the player is below
# an obstacle on the screen Y axis, he'll be drawn above it
#onready var Sorter = get_child(0)

# With the Tilemap in isometric mode, Godot takes in account the center of the tiles 
# if the tilemap is properly configured in the inspector (Cell/Tile Origin)
# so we can remove the half_tile_size variable from the top-down grid example
# Aside from that, nothing changed, the grid works exactly the same!
func _ready():
	for x in range(grid_size.x):
		grid.append([])
		for y in range(grid_size.y):
			grid[x].append(null)

func set_player(value):
	player = value
	player.position = map_to_world(Vector2(12,10))

func get_cell_content(pos=Vector2()):
	return grid[pos.x][pos.y]


func is_cell_vacant(pos=Vector2(), direction=Vector2()):
	var grid_pos = world_to_map(pos) + direction

	if grid_pos.x < grid_size.x and grid_pos.x >= 0:
		if grid_pos.y < grid_size.y and grid_pos.y >= 0:
			return true if grid[grid_pos.x][grid_pos.y] == null else false
	return false


# Nothing new in this function either, the TileMap class takes care of the cartesian to iso conversion
func update_child_pos(pos, direction):
	var grid_pos = world_to_map(pos)
	grid[grid_pos.x][grid_pos.y] = null

	var new_grid_pos = grid_pos + direction

	var target_pos = map_to_world(new_grid_pos) + tile_offset

	# Print statements help to understand what's happening. We're using GDscript's string format operator % to convert
	# Vector2s to strings and integrate them to a sentence. The syntax is "... %s" % value / "... %s ... %s" % [value_1, value_2]
	print("Pos %s, dir %s" % [pos, direction])
	print("Grid pos, old: %s, new: %s" % [grid_pos, new_grid_pos])
	print(target_pos)
	return target_pos
