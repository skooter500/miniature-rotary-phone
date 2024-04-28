@tool

extends MeshInstance3D

@export
var tickness: float = 1.0
@export
var witdh: float = 5
@export
var num_of_points: int = 8
@export
var dist_between_points: float = 0.5
@export
var pos: float = 1
@export_range(0.1, 100)
var druation: float = 1
@export
var play_flapping: bool
@export
var invert: bool

var amplitude: float = 1.0
var frequency: float = 16.0
var phase_shift: float = 2.0
var vertical_shift: float = 1.0

var sin_points: Array[Vector3]

var uvs: PackedVector2Array = PackedVector2Array([
	Vector2(0,1),
	Vector2(0,0),
	Vector2(1,1)
])

var top_vertices: Array = [
	Vector3(-1,1,-1),
	Vector3(1,1,1),
	Vector3(-1,1,1),
	#Triangle 2
	Vector3(1,1,-1),
	Vector3(1,1,1),
	Vector3(-1,1,-1)
]

var bottom_vertices: Array = [
	Vector3(1,-1,1),
	Vector3(-1,-1,-1),
	Vector3(-1,-1,1),
	#Triangle 2
	Vector3(1,-1,1),
	Vector3(1,-1,-1),
	Vector3(-1,-1,-1)
]

var front_vertices: Array = [
	Vector3(1,1,1),
	Vector3(-1,-1,1),
	Vector3(-1,1,1),
	#Triangle 2
	Vector3(1,1,1),
	Vector3(1,-1,1),
	Vector3(-1,-1,1)
]

var back_vertices: Array = [
	Vector3(-1,-1,-1),
	Vector3(1,1,-1),
	Vector3(-1,1,-1),
	#Triangle 2
	Vector3(1,-1,-1),
	Vector3(1,1,-1),
	Vector3(-1,-1,-1)
]

var left_vertices: Array = [
	Vector3(-1,1,1),
	Vector3(-1,-1,1),
	Vector3(-1,-1,-1),
	#Triangle 2
	Vector3(-1,1,1),
	Vector3(-1,-1,-1),
	Vector3(-1,1,-1),
]

var right_vertices: Array = [
	Vector3(1,-1,1),
	Vector3(1,1,1),
	Vector3(1,-1,-1),
	#Triangle 2
	Vector3(1,-1,-1),
	Vector3(1,1,1),
	Vector3(1,1,-1),
]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Godot use a clockwise winding order
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	mesh.clear_surfaces()
	mesh.surface_begin(Mesh.PRIMITIVE_TRIANGLES)

	draw_new_face(top_vertices)
	draw_new_face(bottom_vertices)
	draw_new_face(front_vertices)
	draw_new_face(back_vertices)
	draw_new_face(left_vertices)
	draw_new_face(right_vertices)

	# End drawing.
	mesh.surface_end()

func draw_new_face(vertices: Array):
	for i in range(len(vertices)):
		mesh.surface_set_normal(Vector3(0, 1, 0))
		mesh.surface_set_uv(uvs[i%3])
		mesh.surface_add_vertex(vertices[i])

func create_sin_points()-> void:
	sin_points.clear()
	# Make sure the wings stay in place
	amplitude = pos
	vertical_shift = pos
	for x in range(num_of_points):
		var y = amplitude * sin((x-frequency)/phase_shift)+vertical_shift
		if invert:
			sin_points.append(Vector3(-(x*dist_between_points),y,0))
		else:
			sin_points.append(Vector3(x*dist_between_points,y,0))
	
func create_fronts(next_point: Vector2, prev_point: Vector3):
	var offset = tickness/2
	var witdh_offset = witdh/2
	# a,b,c,d are the four corners in the rectangle. Each point in the sin point
	# represent the midpoint between the corners. a and b are top corners while
	# c and d are bottom corners
	var a = next_point+offset
	var b = prev_point+offset
	var c = next_point-offset
	var d = prev_point-offset

	var vertices = []
	# Construct the triangles
	vertices.append(Vector3())	
