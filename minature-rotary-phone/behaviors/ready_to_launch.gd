class_name ReadyToLaunch extends State

@onready var attacker = get_node("../../Attacker")

var boid
var base
var target

#func get_class():
#	return "ReadyToLaunchState"

func _enter():
	boid = get_parent()
	base = get_node("../../Base")
	boid.velocity = Vector3.ZERO
	boid.global_transform.basis = base.global_transform.basis
	boid.set_enabled_all(false)	
	pass
	
func _think():
	var to_attacker = boid.global_transform.origin.distance_to(attacker.global_transform.origin)
	if to_attacker < 200:
		boid.get_node("StateMachine").change_state(LaunchState.new())

# Called when the node enters the scene tree for the first time.
func _ready():
	boid = get_parent()
	pass # Replace with function body.
