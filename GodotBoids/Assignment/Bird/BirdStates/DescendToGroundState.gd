extends State

class_name DescendToGroundState

func _enter():
	disable_all_behaviours()
	change_behaviour("Constrain", true)	
	change_behaviour("Arrive", true)
	change_behaviour("Avoidance", true)

func _think():
	var arrive = boid.find_child("Arrive")
	var threshold = boid.ground.global_position.y + arrive.slowing_radius 
	if boid.global_position.y <= threshold:
		var wings = boid.find_children("Wing?", "", true, false)
		for wing in wings:
			wing.play_slowdown = true
		var new_state = LandState.new()
		new_state.name = "LandState"
		state_machine.change_state(new_state)
