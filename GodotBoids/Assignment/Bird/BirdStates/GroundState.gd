extends State

class_name GroundState

var stamina_regened: bool

func _enter():
	boid.pause = false
	boid.banking = 0
	boid.max_speed = 5
	var stamina: Stamina = boid.find_child("Stamina")
	stamina.regen = true
	stamina.stamina_replenished.connect(_on_stamina_regen)
	disable_all_behaviours()
	change_behaviour("GroundWander", true)

func _think():
	if stamina_regened:
		var new_state = TakeOffState.new()
		new_state.name = "TakeOffState"
		state_machine.change_state(new_state)

func _exit():
	pass

func _on_stamina_regen():
	stamina_regened = true
