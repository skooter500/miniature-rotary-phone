extends State

class_name TakeOffState

var arrive: Arrive

func _enter():
	disable_all_behaviours()
	arrive = boid.get_node("Arrive")
	if arrive:
		arrive.target = boid.take_off_point
	var body = boid.get_node("MeshInstance3D")
	body.state = "Flying"
	var wings = boid.body.find_children("Wing?")
	for wing in wings:
		wing.play_slowdown = false
	boid.banking = 0.1
	boid.max_speed = boid.flight_speed
	change_behaviour("Arrive", true)

func _think():
	if arrive and arrive.target.position.distance_to(boid.global_position) < 5:
		var new_state = FlockState.new()
		new_state.name = "FlockState"
		state_machine.change_state(new_state)
