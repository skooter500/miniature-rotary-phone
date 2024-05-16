class_name GroundWander extends SteeringBehavior

@export var distance:float = 20
@export var radius:float  = 10
@export var jitter:float = 50

var target:Vector3
var world_target:Vector3
var wander_target:Vector3

func _ready():
	boid = get_parent()
	wander_target = Vector3(randf_range(-1.0,1.0),boid.global_position.y,randf_range(-1.0,1.0)) * radius
		
func on_draw_gizmos():
	var cent = boid.global_transform * (Vector3.BACK * distance)
	#var cent = wander_target	
	var top = cent + Vector3(0,0.1,0)
	var bottom = cent - Vector3(0,0.1,0)
	DebugDraw3D.draw_cylinder_ab(top,bottom,radius, Color.DARK_SLATE_BLUE)
	DebugDraw3D.draw_line(boid.global_transform.origin, cent, Color.DARK_SLATE_BLUE)
	DebugDraw3D.draw_line(cent, world_target, Color.DARK_SLATE_BLUE, 0.1)			
	DebugDraw3D.draw_position(Transform3D(Basis(), world_target), Color.DARK_SLATE_BLUE)			

func calculate():		
	var delta = get_process_delta_time()
	var disp = jitter * Vector3(randf_range(-1.0,1.0),0,randf_range(-1.0,1.0)) * delta
	wander_target += disp
	wander_target = wander_target.limit_length(radius) * Vector3(1,0,1)
	var local_target = (Vector3.BACK * distance) + wander_target
	world_target = boid.global_transform * (local_target) * Vector3(1,0,1)
	world_target.y = boid.height/2
	return boid.seek_force(world_target)
