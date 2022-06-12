class_name Utilities


static func _draw_isometric_cell_outline(canvas_item: CanvasItem, grid_origin: Vector2, cell_size: Vector2, cell: Vector2, color := Color.white, outline_width := 4.0) -> void:
	var colors : PoolColorArray
	for i in range(4):
		colors.append(color)

	var points : PoolVector2Array
	for i in range(4):
		var point := Vector2.ZERO
		point.x += cell_size.x * 0.5
		point.x += outline_width
		point = point.rotated(TAU / 4 * i)
		if not i % 2 == 0:
			point *= cell_size.y / cell_size.x
		var offset = cell * cell_size
		point += offset
		point.x += cell_size.x * 0.5
		points.append(point)

	canvas_item.draw_polygon(points, colors)


static func draw_isometric_grid(canvas_item: CanvasItem, grid_origin: Vector2, cell_size: Vector2, cell_amount: Vector2, width: float, color := Color.white) -> void:
	var outer_rect := Rect2(grid_origin, cell_size * cell_amount)
	canvas_item.draw_rect(outer_rect, color, false, width)
	for cellx in cell_amount.x:
		var rect_x := Rect2(grid_origin.x + (cell_size.x * cellx), grid_origin.y, cell_size.x, cell_size.y)
		canvas_item.draw_line(rect_x.position, rect_x.end, color, width)
		canvas_item.draw_line(Vector2(rect_x.end.x, rect_x.position.y), Vector2(rect_x.position.x, rect_x.end.y), color, width)
		for celly in cell_amount.y:
			var rect_y := Rect2(rect_x.position.x, rect_x.position.y + (cell_size.y * celly), cell_size.x, cell_size.y)
			canvas_item.draw_line(rect_y.position, rect_y.end, color, width)
			canvas_item.draw_line(Vector2(rect_y.end.x, rect_y.position.y), Vector2(rect_y.position.x, rect_y.end.y), color, width)
