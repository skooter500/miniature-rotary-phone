class_name Seek extends SteeringBehavior

@export var target:Node3D
var world_target:Vector3

func on_draw_gizmos():
	if target:
		world_target = target.global_transform.origin
		DebugDraw3D.draw_position(target.global_transform, Color.AQUA)
		DebugDraw3D.draw_line(boid.global_transform.origin, world_target, Color.AQUA)

func calculate():
	if target:		
		world_target = target.global_transform.origin
	return boid.seek_force(world_target)


# Called when the node enters the scene tree for the first time.
func _ready():
	boid = get_parent()
