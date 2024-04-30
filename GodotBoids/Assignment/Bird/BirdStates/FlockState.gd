extends State

class_name FlockState

var stamina: Stamina

var stamina_deplated: bool = false

func _enter():
	stamina = boid.find_child("Stamina")
	stamina.regen = false
	stamina.stamina_depleted.connect(_on_stamina_depleted)
	disable_all_behaviours()
	change_behaviour("Separation", true)
	change_behaviour("Alignment", true)
	change_behaviour("Cohesion", true)
	change_behaviour("Harmonic", true)
	change_behaviour("Constrain", true)
	change_behaviour("NoiseWander", true)
	
func _think():
	if stamina_deplated:
		var new_state = DescendToGroundState.new()
		new_state.name = "DescendToGroundState"
		state_machine.change_state(new_state)

func _on_stamina_depleted():
	stamina_deplated = true
