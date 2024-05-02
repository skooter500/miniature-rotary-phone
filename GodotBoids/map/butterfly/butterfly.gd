extends Node3D

var body : MeshInstance3D
var left_wing : MeshInstance3D
var right_wing : MeshInstance3D
var max_flap_angle = 95.0
var time : float
var flap_speed = randf_range(10.0, 20.0)
var boid

# Called when the node enters the scene tree for the first time.
func _ready():
	Parameters.connect("BUTTERFLY_SPEED", set_speed)
	Parameters.connect("DRAW_GIZMOS_BUTTERFLY", gizmos_drawn)
	Parameters.connect("SET_DAY_NIGHT", _set_glow)
	Parameters.connect("FIND_FLOWERS", _set_arrive)
	
	boid = get_node("Boid")
	body =  get_node("Boid/Body");
	left_wing =  get_node("Boid/wing");
	right_wing = get_node("Boid/wing2");
	left_wing.get_active_material(0).albedo_color = Color(randf(), randf(), randf())

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time += delta
	var flap_angle = sin(time * flap_speed) * max_flap_angle
	body.transform.origin.y = -(flap_angle/64)
	left_wing.rotation_degrees.z = flap_angle
	right_wing.rotation_degrees.z = -flap_angle

func set_speed(new_speed):
	print("setting butterfly speed to", new_speed)
	boid.speed = new_speed
	boid.max_speed = new_speed * 2
	boid.max_force = new_speed * 2

func gizmos_drawn(value):
	boid.draw_gizmos = value
	get_node("Boid/Avoidance").draw_gizmos = value
	get_node("Boid/Wander").draw_gizmos = value
	get_node("Boid/NoiseWander").draw_gizmos = value
	get_node("Boid/ArriveToFlowers").draw_gizmos = value
	get_node("Boid/Constrain").draw_gizmos = value

func _set_glow(value):
	print("Butterflies glowing")
	var material = left_wing.get_active_material(0)
	if value:
		material.emission_enabled = value
		material.emission = Color(randf(), randf(), randf())
		material.emission_energy_multiplier = 2
	else:
		material.emission_enabled = false

func _set_arrive(value):
	get_node("Boid/ArriveToFlowers").enabled = value
