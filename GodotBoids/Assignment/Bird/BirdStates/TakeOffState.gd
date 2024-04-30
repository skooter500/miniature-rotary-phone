extends State

class_name TakeOffState

func _enter():
	disable_all_behaviours()
	var arrive: Arrive = boid.get_node("Arrive")
	if arrive:
		arrive.target = boid.take_off_point
	var body = boid.get_node("MeshInstance3D")
	body.state = "Flying"
	var wings = boid.find_children("Wing?", "", true, false)
	for wing in wings:
		wing.play_slowdown = false
	change_behaviour("Arrive", true)

func _think():
	pass
