extends Path3D

var path: Path3D

func draw_gizmos():
	# DebugDraw.draw_box(box_pos, Vector3(10, 20, 10), Color(0, 1, 0))
	# DebugDraw.draw_line(transform.origin,  seekTarget , Color(1, 1, 0))
	for i in range(1, path.get_curve().get_point_count()):
		var start = transform * (path.get_curve().get_point_position(i - 1))
		var end = transform * (path.get_curve().get_point_position(i))
		#DebugDraw3D.draw_line(start, end , Color.CYAN)

func _ready():
	path = $"."
	pass

func _process(delta):
	draw_gizmos()
