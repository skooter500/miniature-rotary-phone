class_name Constrain extends SteeringBehavior

@export var radius:float = 100

@export var center_path:NodePath

var center

func on_draw_gizmos():
	var center_pos = center.global_transform.origin if center else Vector3.ZERO 
	DebugDraw3D.draw_sphere(center_pos, radius, Color.BEIGE)


func calculate():
#	Inline IF!! 
	var to_center = center.global_transform.origin - boid.global_transform.origin if center else - boid.global_transform.origin 
#	
	var power = max(to_center.length() - radius, 0)
	return to_center.limit_length(power)
	
# Called when the node enters the scene tree for the first time.
func _ready():
	boid = get_parent()
	if center_path:
		center = get_node(center_path)
	# boid.transform.rotated()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
