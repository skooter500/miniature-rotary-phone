extends Node3D

var target
var cam


# Called when the node enters the scene tree for the first time.
func _ready():
	target = get_parent().find_child("camTarget", true)
	cam = get_parent().find_child("Camera3D", true)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	# transform.origin += transform.basis.z
	cam.global_position = lerp(cam.global_position, target.global_position, delta * 2)
	cam.look_at(target.get_parent_node_3d().global_position, Vector3.UP)
	# pass
