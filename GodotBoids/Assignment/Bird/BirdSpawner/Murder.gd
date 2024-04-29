extends School

@export
var starting_point: Vector3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()
	center = get_node(center_path)
	center.position = starting_point
	for i in count:
		var crow = fish_scene.instantiate()		
		var pos = (Utils.random_point_in_unit_sphere() * radius)+starting_point
		add_child(crow)
		crow.global_position = pos
		crow.global_rotation = Vector3(0, randf_range(0, PI * 2.0),  0)
		var boid = crow
		if boids.size() == 0:
			boid.draw_gizmos = true
		boids.push_back(boid)		
		var constrain = boid.get_node("Constrain")
		if constrain:
			constrain.center = center
			constrain.radius = radius

