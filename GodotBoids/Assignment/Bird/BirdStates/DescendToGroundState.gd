extends State

class_name DescendToGroundState

var arrive: Arrive

func _enter():
	disable_all_behaviours()
	arrive = boid.get_node("Arrive")
	if arrive:
		arrive.randomise_target()
	change_behaviour("Constrain", true)	
	change_behaviour("Arrive", true)
	change_behaviour("Avoidance", true)
	change_behaviour("ObAvoidance", true)

func _think():
	var threshold = boid.ground.global_position.y + arrive.slowing_radius 
	if boid.global_position.y <= threshold:
		var wings = boid.find_children("Wing?", "", true, false)
		for wing in wings:
			wing.play_slowdown = true
		var new_state = LandState.new()
		new_state.name = "LandState"
		state_machine.change_state(new_state)
