class_name ArriveToFlowers extends SteeringBehavior

@export var target:Node3D
@export var slowing_radius:float = 20 
var flower_pos

# Called when the node enters the scene tree for the first time.
func _ready():
	boid = get_parent()
	Parameters.connect("FLOWER_POSITION", get_position)
	
func get_position(flower_position):
	flower_pos = flower_position

func on_draw_gizmos():
	DebugDraw3D.draw_position(flower_pos, Color.AQUAMARINE)
	DebugDraw3D.draw_sphere(flower_pos.origin, slowing_radius, Color.AQUAMARINE)
	# DebugDraw.draw_arrow_line(boid.global_transform.origin, target.global_transform.origin, Color.aquamarine)

func calculate():
	return boid.arrive_force(flower_pos.origin, slowing_radius)

