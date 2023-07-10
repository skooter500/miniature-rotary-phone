class_name LaunchState extends State

var base 

var boid
var target

func _enter():
	boid = get_parent()
	base = get_node("../../Base")
	target = base.global_transform.origin + base.global_transform.basis.z * 50
	boid.get_node("Seek").world_target = target
	boid.get_node("Seek").set_enabled(true)
	boid.get_node("Sounds").play_sound(0)

func _exit():
	boid.get_node("Seek").set_enabled(false)
	pass

func _think():
	if target.distance_to(boid.global_transform.origin) < 5:
		boid.get_node("StateMachine").change_state(DefendState.new())

func get_class():
	return "LaunchState"
