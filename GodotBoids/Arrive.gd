class_name Arrive extends SteeringBehavior

@export var target_node:NodePath
@onready var target = get_node(target_node)

@export var slowing_radius:float = 20 

func on_draw_gizmos():
	DebugDraw.draw_sphere(target.global_transform.origin, slowing_radius, Color.AQUAMARINE)
	# DebugDraw.draw_arrow_line(boid.global_transform.origin, target.global_transform.origin, Color.aquamarine)

func calculate():
	return boid.arrive_force(target.global_transform.origin, slowing_radius)

# Called when the node enters the scene tree for the first time.
func _ready():
	boid = get_parent()
	pass # Replace with function body.
