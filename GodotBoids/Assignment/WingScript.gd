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
# Broken?
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

	#draw_faces(top_vertices)
	create_wing()
	#draw_new_face(bottom_vertices)
	#draw_new_face(front_vertices)
	#draw_new_face(back_vertices)
	#draw_new_face(left_vertices)
	#draw_new_face(right_vertices)

	# End drawing.
	mesh.surface_end()

func draw_faces(vertices: Array):
	for i in range(len(vertices)):
		mesh.surface_set_normal(Vector3(0, 1, 0))
		mesh.surface_set_uv(uvs[i%3])
		mesh.surface_add_vertex(vertices[i])

func create_sin_points()-> Array:
	var points = []
	# Make sure the wings stay in place
	amplitude = pos
	vertical_shift = pos
	for x in range(num_of_points):
		var y = amplitude * sin((x-frequency)/phase_shift)+vertical_shift
		#var y
		#if x == 0:
			#y = amplitude * sin((x-frequency))+vertical_shift
		#else:
			#y = amplitude * sin((x-frequency)/phase_shift)+vertical_shift
		if invert:
			points.append(Vector3(-(x*dist_between_points),y,0))
		else:
			points.append(Vector3(x*dist_between_points,y,0))
	return points

func create_wing():
	var points = create_sin_points()
	var vertices
	for i in range(num_of_points):
		var next_point = points[i]
		var prev_point = points[i-1]
		if i == 0:
			continue
		if i == (num_of_points-1):
			vertices = create_end_face(next_point, prev_point)
			draw_faces(vertices)
			continue
		vertices = create_fronts(next_point, prev_point)
		draw_faces(vertices)
		vertices = create_tops(next_point, prev_point)
		draw_faces(vertices)

func create_fronts(next_point: Vector3, prev_point: Vector3):
	var offset = tickness/2
	var width_offset = witdh/2
	# a,b,c,d are the four corners in the rectangle. Each point in the sin point
	# represent the midpoint between the corners. a and b are top corners while
	# c and d are bottom corners
	var a = next_point.y+offset
	var b = prev_point.y+offset
	var c = next_point.y-offset
	var d = prev_point.y-offset

	var vertices = []
	# Construct the triangles
	# Front face
	# First triangle
	vertices.append(Vector3(next_point.x,a,width_offset))
	vertices.append(Vector3(prev_point.x,b,width_offset))
	vertices.append(Vector3(next_point.x,c,width_offset))
	# Second triangle
	vertices.append(Vector3(prev_point.x,b,width_offset))
	vertices.append(Vector3(prev_point.x,d,width_offset))
	vertices.append(Vector3(next_point.x,c,width_offset))
	# Back face
	# First triangle	
	vertices.append(Vector3(next_point.x,a,-width_offset))
	vertices.append(Vector3(next_point.x,c,-width_offset))
	vertices.append(Vector3(prev_point.x,b,-width_offset))
	# Second triangle
	vertices.append(Vector3(prev_point.x,b,-width_offset))
	vertices.append(Vector3(next_point.x,c,-width_offset))
	vertices.append(Vector3(prev_point.x,d,-width_offset))
	
	return vertices

func create_tops(next_point: Vector3, prev_point: Vector3):
	var offset = tickness/2
	var width_offset = witdh/2
	
	var a = next_point.z+width_offset
	var b = next_point.z-width_offset
	var c = prev_point.z+width_offset
	var d = prev_point.z-width_offset
	
	var vertices = []
	# Construct the triangles
	# Top face
	# First triangle	
	vertices.append(Vector3(next_point.x,next_point.y+offset,a))
	vertices.append(Vector3(next_point.x,next_point.y+offset,b))
	vertices.append(Vector3(prev_point.x,prev_point.y+offset,c))
	# Second triangle
	vertices.append(Vector3(next_point.x,next_point.y+offset,b))
	vertices.append(Vector3(prev_point.x,prev_point.y+offset,d))
	vertices.append(Vector3(prev_point.x,prev_point.y+offset,c))
	# Bottom face
	# First triangle	
	vertices.append(Vector3(next_point.x,next_point.y-offset,a))
	vertices.append(Vector3(prev_point.x,prev_point.y-offset,c))
	vertices.append(Vector3(next_point.x,next_point.y-offset,b))
	# Second triangle
	vertices.append(Vector3(next_point.x,next_point.y-offset,b))
	vertices.append(Vector3(prev_point.x,prev_point.y-offset,c))
	vertices.append(Vector3(prev_point.x,prev_point.y-offset,d))
	return vertices

func create_end_face(next_point: Vector3, prev_point: Vector3):
	var offset = tickness/2
	var width_offset = witdh/2
	
	var a = next_point.z+width_offset
	var b = next_point.z-width_offset
	var c = prev_point.z+width_offset
	var d = prev_point.z-width_offset
	
	var vertices = []
	# Construct the triangles
	# Top face
	# First triangle	
	vertices.append(Vector3(next_point.x,next_point.y,a))
	vertices.append(Vector3(next_point.x,next_point.y,b))
	vertices.append(Vector3(prev_point.x,prev_point.y+offset,c))
	# Second triangle
	vertices.append(Vector3(next_point.x,next_point.y,b))
	vertices.append(Vector3(prev_point.x,prev_point.y+offset,d))
	vertices.append(Vector3(prev_point.x,prev_point.y+offset,c))
	# Bottom face
	# First triangle	
	vertices.append(Vector3(next_point.x,next_point.y,a))
	vertices.append(Vector3(prev_point.x,prev_point.y-offset,c))
	vertices.append(Vector3(next_point.x,next_point.y,b))
	# Second triangle
	vertices.append(Vector3(next_point.x,next_point.y,b))
	vertices.append(Vector3(prev_point.x,prev_point.y-offset,c))
	vertices.append(Vector3(prev_point.x,prev_point.y-offset,d))
	# Front face
	# First triangle	
	vertices.append(Vector3(next_point.x,next_point.y,width_offset))
	vertices.append(Vector3(prev_point.x,prev_point.y+offset,width_offset))
	vertices.append(Vector3(prev_point.x,prev_point.y-offset,width_offset))
	# Back face
	# Second triangle
	vertices.append(Vector3(prev_point.x,prev_point.y+offset,-width_offset))
	vertices.append(Vector3(next_point.x,next_point.y,-width_offset))
	vertices.append(Vector3(prev_point.x,prev_point.y-offset,-width_offset))
	return vertices
