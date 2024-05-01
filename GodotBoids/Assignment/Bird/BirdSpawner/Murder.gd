extends School

class_name Murder

@export
var starting_point: Vector3
@export
var ground: Ground
@export
var take_off_maker: Marker3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()
	center = get_node(center_path)
	center.position = starting_point
	take_off_maker.position = starting_point*0.25
	for i in count:
		spawn_crow()
		
func spawn_crow() -> void:
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
	boid.ground = ground
	boid.take_off_point = take_off_maker
	boid.centre_point = center

func clear_crows():
	for crow in get_children():
		crow.queue_free()
		
#func on_ui_request(node_name,property_name,value):
	
