class_name Arrive extends SteeringBehavior

@export var target:Node3D

@export
var multiple_targets: bool = false

@export
var targets: Array[Node3D] = []

@export var slowing_radius:float = 20 

func on_draw_gizmos():
	if target: 
		DebugDraw3D.draw_position(target.global_transform, Color.AQUAMARINE)
		DebugDraw3D.draw_sphere(target.global_transform.origin, slowing_radius, Color.AQUAMARINE)
	# DebugDraw.draw_arrow_line(boid.global_transform.origin, target.global_transform.origin, Color.aquamarine)

func calculate():
	return boid.arrive_force(target.global_transform.origin, slowing_radius)

func randomise_target():
	if multiple_targets and not targets.is_empty():
		randomize()
		target = targets.pick_random()
		
# Called when the node enters the scene tree for the first time.
func _ready():
	boid = get_parent()
	pass # Replace with function body.
