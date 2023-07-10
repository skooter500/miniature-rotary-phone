extends MeshInstance3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

@export var speed:float = 1.0 

@export var rot_speed = PI / 2



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	# Move the object forward in world space

	# Unity
	# tranform.Translate(0, 0, 1, Space.World)
	# transform.position += Vector3.Forward
	
	
	# Godot
	# translate(Vector3.FORWARD)
	# global_transform.origin += Vector3.FORWARD
	# global_transform = global_transform.translated(Vector3.FORWARD)
	
	# Move the object in local space
	# tranform.Translate(0, 0, 1)
	# transform.position += tranform.forward
	
	# Godot
	# translate_object_local(- Vector3.FORWARD)
	# transform.origin += transform.basis.z
	# transform = transform.translated(transform.basis.z)
	
	# Unity
	# transform.Rotate(x, y, z)
	# Quaterion.LookAt()
	# 
	# transform.rotation *= QUatarenion.AngleAxis(angle, Vector.Up);
	
	# rotate(Vector3.UP, rot_speed * delta)
	# rotate_y(rot_speed * delta)
	# transform.basis = transform.basis.rotated(Vector3.UP, rot_speed * delta)
	global_transform.basis = global_transform.basis.rotated(Vector3.UP, rot_speed * delta)
	
	global_transform = global_transform.looking_at($"../Marker3D".global_transform.origin, Vector3.UP)
	
	
	
	pass
