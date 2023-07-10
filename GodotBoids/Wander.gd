class_name Wander extends SteeringBehavior

@export var distance:float = 20
@export var radius:float  = 10
@export var jitter:float = 50

enum Axis { Horizontal, Vertical}

@export var axis = Axis.Horizontal
var target:Vector3
var world_target:Vector3
var wander_target:Vector3

func _ready():
	boid = get_parent()
	wander_target = Utils.random_point_in_unit_sphere() * radius
		
func draw_gizmos():
	var cent = boid.global_transform * (Vector3.BACK * distance)
	DebugDraw.draw_sphere(cent, radius, Color.DARK_SLATE_BLUE)
	DebugDraw.draw_line(boid.global_transform.origin, cent, Color.DARK_SLATE_BLUE)
	DebugDraw.draw_arrow_line(cent, world_target, Color.DARK_SLATE_BLUE, 0.1)			

func calculate():		
	var delta = get_process_delta_time()
	var disp = jitter * Utils.random_point_in_unit_sphere() * delta
	wander_target += disp
	wander_target = wander_target.limit_length(radius)
	var local_target = (Vector3.BACK * distance) + wander_target

	world_target = boid.global_transform * (local_target)
	# print("world" + str(worldTarget))
	
	return boid.seek_force(world_target)
