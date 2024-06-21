class_name Separation extends SteeringBehavior 

var force = Vector3.ZERO
# Called when the node enters the scene tree for the first time.
func _ready():
	boid = get_parent()
	boid.count_neighbors = true

func on_draw_gizmos():
	for i in boid.neighbors.size():
		var other = boid.neighbors[i]
		var to_other = boid.neighbors[i].global_transform.origin - boid.global_transform.origin
		to_other = to_other.normalized()
		DebugDraw3D.draw_arrow(boid.global_transform.origin, boid.global_transform.origin + to_other * force.length() * weight * 5, Color.DARK_SEA_GREEN, 0.1)

func calculate():
	force = Vector3.ZERO
	for i in boid.neighbors.size():
		var other = boid.neighbors[i]
		var away = boid.global_transform.origin - other.global_transform.origin
		force += away.normalized() / away.length()
	return force
