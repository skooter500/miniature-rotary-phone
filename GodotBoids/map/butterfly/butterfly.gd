extends Node3D

var body : MeshInstance3D
var left_wing : MeshInstance3D
var right_wing : MeshInstance3D
var max_flap_angle = 95.0
var time : float
var flap_speed = randf_range(5.0, 10.0)
var boid

# Called when the node enters the scene tree for the first time.
func _ready():
	Parameters.connect("BUTTERFLY_SPEED", set_speed)
	
	boid = get_node("Boid")
	body =  get_node("Boid/Body");
	left_wing =  get_node("Boid/wing");
	right_wing = get_node("Boid/wing2");

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
