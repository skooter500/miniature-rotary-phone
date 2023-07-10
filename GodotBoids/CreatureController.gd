extends Node

@onready var boid = $"../boid/"
@onready var player = $"../../Player"
@onready var pod = $"../tail/Pod"

var in_pod = false

func _input(event):
	if event is InputEventKey and event.keycode == KEY_Z and event.pressed:
		in_pod = false
		boid.get_node("Harmonic").set_enabled(true)
		boid.get_node("NoiseWander").set_enabled(true)
		boid.get_node("UserSteering").set_enabled(false)
		boid.get_node("Constrain").set_enabled(true)
		player.can_move = true

func _physics_process(delta):
	if in_pod:
		player.global_transform.origin = lerp(player.global_transform.origin, pod.global_transform.origin, delta * 5)	
		var desired = pod.global_transform.basis.rotated(pod.global_transform.basis.y, PI)
		player.global_transform.basis = player.global_transform.basis.slerp(desired, delta * 5).orthonormalized()

func _ready():
	# player.global_transform.origin = lerp(player.global_transform.origin, pod.global_transform.origin, delta)
	
	
	pass # Replace with function body.




func _on_Area_body_exited(area):
	in_pod = false
	pass # Replace with function body.


func _on_Pod_body_entered(body):
	if body.name == "Player":
		print("entering pod")
		in_pod = true
		boid.get_node("Harmonic").set_enabled(false)
		boid.get_node("NoiseWander").set_enabled(false)
		boid.get_node("Constrain").set_enabled(true)
		boid.get_node("UserSteering").set_enabled(true)
	
		player.can_move = false
		pass # Replace with function body.
