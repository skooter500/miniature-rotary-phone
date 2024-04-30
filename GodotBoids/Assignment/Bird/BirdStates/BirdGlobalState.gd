extends State

class_name BirdGlobalState

@export
var stamina: Stamina

@export
var ground_states = [
	"DescendToGroundState",
	"LandState",
	"GroundState"
]

func _enter():
	if stamina == null:
		print("Bird Global State is missing the stamina node")
		return
	stamina.stamina_depleted.connect(_on_stamina_depleted)
	stamina.stamina_replenished.connect(_on_stamina_regen)

func _think():
	print(state_machine.current_state.name)
	pass

func _on_stamina_depleted():
	pass
	
func _on_stamina_regen():
	pass
