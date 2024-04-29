extends Node3D

var body : MeshInstance3D
var left_wing : MeshInstance3D
var right_wing : MeshInstance3D
var max_flap_angle = 95.0
var time : float
var flap_speed = randf_range(5.0, 10.0)

# Called when the node enters the scene tree for the first time.
func _ready():
	body =  get_node("Boid/Body");
	left_wing =  get_node("Boid/Body/wing");
	right_wing = get_node("Boid/Body/wing2");

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time += delta
	var flap_angle = sin(time * flap_speed) * max_flap_angle
	left_wing.rotation_degrees.z = flap_angle
	right_wing.rotation_degrees.z = -flap_angle
