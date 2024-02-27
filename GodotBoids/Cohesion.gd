class_name Cohesion extends SteeringBehavior


var force = Vector3.ZERO
var center_of_mass
# Called when the node enters the scene tree for the first time.
func _ready():
	boid = get_parent()
	boid.count_neighbors = true

func on_draw_gizmos():
	DebugDraw3D.draw_arrow(boid.global_transform.origin, center_of_mass, Color.DARK_SEA_GREEN, 0.1)
	
func calculate():
	
	force = Vector3.ZERO
	center_of_mass = Vector3.ZERO
	for i in boid.neighbors.size():
		var other = boid.neighbors[i]
		center_of_mass += other.global_transform.origin
	if boid.neighbors.size() > 0:
		center_of_mass /= boid.neighbors.size()
		force = boid.seek_force(center_of_mass).normalized()
	return force
	
