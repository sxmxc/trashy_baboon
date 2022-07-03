extends Node2D

signal end_turn

onready var status_label = $StatusLabel

var rng = RandomNumberGenerator.new()

enum Status {THINKING, MOVING, ATTACKING, USING_ABILITY, HEALING, DONE}

var gameboard = null
var target = null
var target_cell = null
var ai_control = false
var unit = null
var walkable_cells
var ai_status

func _ready():
	rng.seed = OS.get_time().second
	rng.randomize()

func task_check_control(task):
	ai_status = Status.THINKING
	if ai_control:
		task.succeed()
	else:
		task.failed()

func task_has_walkable_cells(task):
	ai_status = Status.THINKING
	print("AI: Checking walkable cells")
	if walkable_cells:
		print("AI: Has walkable cells")
		task.succeed()
	else:
		print("AI: Does not have walkable cells")
		task.failed()

func task_find_target_cell(task):
	print("AI: Finding target cell")
	if walkable_cells:
		ai_status = Status.MOVING
		var random_index = rng.randi_range(0,walkable_cells.size()-1)
		var random_cell = walkable_cells[random_index]
		target_cell = random_cell
		gameboard.draw_unit_path(target_cell)
		task.succeed()
	else:
		task.failed()

func task_move(task):
	print("AI: Attempting to move")
	if target_cell:
		if !gameboard.move_active_unit(target_cell):
			print("AI: Move failed")
			task.failed()
			return
		print("AI: Move success")
		task.succeed()
	else:
		print("AI: Move failed")
		task.failed()

func task_set_target(task):
	ai_status = Status.THINKING
	task.succeed()

func task_end_turn(task):
	if gameboard.grid.calculate_grid_coordinates(position) != target_cell:
		task.failed() 
	ai_status = Status.DONE
	print("AI: Ending turn")
	ai_control = false
	emit_signal("end_turn")
	task.succeed()
	target_cell = null
	
func task_show_status(task):
	status_label.visible = task.get_param(0) as bool
	task.succeed()
	
func task_set_status(task):
	status_label.set_text(task.get_param(0) as String)
	task.succeed()
