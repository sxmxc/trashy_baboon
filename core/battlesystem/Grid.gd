tool
extends TileMap
class_name Grid

export var size := Vector2(20, 20)

# Half of ``cell_size``.
# We will use this to calculate the center of a grid cell in pixels, on the screen.
# That's how we can place units in the center of a cell.
var _half_cell_size = cell_size / 2

var tile_dict = {
	"grass": 1,
	"stone": 5,
	"dirt": 9,
	"water": 10
}
var tile_types = ["grass", "stone", "dirt", "water"]

var rng = RandomNumberGenerator.new()

func _ready():
	rng.seed = OS.get_time().second
	rng.randomize()
	_clear_map()
	_generate_map()
	pass # Replace with function body.


func _clear_map():
	print("Clearing map")
	var cells = get_used_cells()
	for cell in cells:
			set_cell(cell.x,cell.y, -1)
	
func _generate_map():
	print("Generating map")
	for x in size.x:
		for y in size.y:
			var rando = rng.randi_range(0, tile_types.size() - 1)
			set_cell(x,y, tile_dict[tile_types[0]])


func calculate_map_position(grid_position: Vector2) -> Vector2:
	return(map_to_world(grid_position))


func calculate_grid_coordinates(map_position: Vector2) -> Vector2:
	return(world_to_map(map_position))

# Returns true if the `cell_coordinates` are within the grid.
# This method and the following one allow us to ensure the cursor or units can never go past the
# map's limit.
func is_within_bounds(cell_coordinates: Vector2) -> bool:
	var out := cell_coordinates.x >= 0 and cell_coordinates.x < size.x
	return out and cell_coordinates.y >= 0 and cell_coordinates.y < size.y

# Makes the `grid_position` fit within the grid's bounds.
# This is a clamp function designed specifically for our grid coordinates.
# The Vector2 class comes with its `Vector2.clamp()` method, but it doesn't work the same way: it
# limits the vector's length instead of clamping each of the vector's components individually.
# That's why we need to code a new method.
func clamp(grid_position: Vector2) -> Vector2:
	var out := grid_position
	out.x = clamp(out.x, 0, size.x - 1.0)
	out.y = clamp(out.y, 0, size.y - 1.0)
	return out


# Given Vector2 coordinates, calculates and returns the corresponding integer index. You can use
# this function to convert 2D coordinates to a 1D array's indices.
func as_index(cell: Vector2) -> int:
	return int(cell.x + size.x * cell.y)
