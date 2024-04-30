@tool

extends MeshInstance3D

class_name Wing

@export
var tickness: float = 1.0
@export
var width: float = 5
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
var play_slowdown: bool
# In degrees
@export_range(0,360)
var wind_direction: float = 0
@export_range(0,90)
var wind_threshold: float = 7.5
@export
var invert: bool
@export
var retract_width: float = 0.5

@export
var material: StandardMaterial3D

@export
var parent: Bird

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

var tween: Tween

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	wind_direction = parent.wind_direction
	parent.wind_direction_update.connect(on_wind_direction_update)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var threshold_lower = wind_direction-wind_threshold
	var threshold_higher = wind_direction+wind_threshold
	if parent.rotation_degrees.x > 1 and parent.rotation_degrees.x < 180:
		play_flapping = false
	elif (parent.rotation_degrees.y > threshold_lower and parent.rotation_degrees.y < threshold_higher):
		play_flapping = false
	else:
		play_flapping = true
	
	if (tween == null or not tween.is_running()) and play_slowdown: 
		tween = get_tree().create_tween()
		tween.set_ease(Tween.EASE_IN)
		tween.set_trans(Tween.TRANS_BACK)
		tween.tween_property(self, "pos", 1, druation)
		tween.play()

	if (tween == null or not tween.is_running()) and play_flapping and not play_slowdown: 
		tween = get_tree().create_tween()
		tween.set_ease(Tween.EASE_IN)
		tween.set_trans(Tween.TRANS_BACK)
		tween.tween_property(self, "pos", 1, druation)
		tween.chain().tween_property(self, "pos", -1, druation)
		tween.play()
	create_mesh()

func on_wind_direction_update(new_value):
	wind_direction = new_value

func create_mesh() -> void:
	# Clear the old surface
	mesh.clear_surfaces()
	mesh.surface_begin(Mesh.PRIMITIVE_TRIANGLES)
	# Godot use a clockwise winding order
	create_wing()
	# End drawing.
	mesh.surface_end()
	mesh.surface_set_material(0, material)

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
		if invert:
			points.append(Vector3(-(x*dist_between_points),y,0))
		else:
			points.append(Vector3(x*dist_between_points,y,0))
	return points

func create_wing():
	var points = create_sin_points()
	if num_of_points <= 1:
		create_retracted_wing()
		return
	else:
		create_extended_wing(points)

func create_retracted_wing():
	var next_point = Vector3(-retract_width,0,0)
	var prev_point = Vector3(0,0,0)
	var vertices = create_end_face(next_point, prev_point)
	draw_faces(vertices)

func create_extended_wing(points):
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
	var width_offset = width/2
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
	var width_offset = width/2
	
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
	var width_offset = width/2
	
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
