class_name DockedState extends State

@onready var attacker = get_node("../../Attacker")

var boid
var base
var target

func _get_class():
	return "DockedState"

func _enter():
	boid = get_parent()
	base = get_node("../../Base")
	target = base.global_transform.origin
	boid.get_node("Seek").world_target = target
	boid.get_node("Seek").set_enabled(true)
	boid.get_node("Sounds").play_sound(3)
	pass

func _exit():
	boid.get_node("Sounds").play_sound(4)
	
func _think():
	var to_base = boid.global_transform.origin.distance_to(base.global_transform.origin)
	if to_base < 5:
		boid.get_node("StateMachine").change_state(ReadyToLaunch.new())
	
# Called when the node enters the scene tree for the first time.
func _ready():
	boid = get_parent()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
