extends State

class_name DescendToGroundState


func _enter():
	change_behaviour("Separation", false)
	change_behaviour("Alignment", false)
	change_behaviour("Cohesion", false)
	change_behaviour("Harmonic", false)
	change_behaviour("NoiseWander", false)
	change_behaviour("Arrive", true)
	change_behaviour("Avoidance", true)
	pass

func _think():
	var threshold = boid.ground.global_position.y + 20
	if boid.global_position.y <= threshold:
		var wings = boid.find_children("Wing?", "", true, false)
		for wing in wings:
			wing.play_slowdown = true
		var new_state = LandState.new()
		new_state.name = "LandState"
		state_machine.change_state(new_state)
