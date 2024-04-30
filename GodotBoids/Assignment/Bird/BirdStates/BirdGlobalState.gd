extends State

class_name BirdGlobalState

@export
var stamina: Stamina

@export
var ground_states = [
	"DescendToGroundState",
	"LandState"
]

func _enter():
	if stamina == null:
		print("Bird Global State is missing the stamina node")
		return
	stamina.stamina_depleted.connect(_on_stamina_depleted)
	stamina.stamina_replenished.connect(_on_stamina_regen)

func _think():
	pass

func _on_stamina_depleted():
	print(state_machine.current_state.name)
	if not state_machine.current_state.name in ground_states:
		var new_state = DescendToGroundState.new()
		new_state.name = "DescendToGroundState"
		state_machine.change_state(new_state)
	
func _on_stamina_regen():
	pass
