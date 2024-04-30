extends State

class_name BirdGlobalState

@export
var stamina: Stamina

func _enter():
	if stamina == null:
		print("Bird Global State is missing the stamina node")
		return
	stamina.stamina_depleted.connect(_on_stamina_depleted)
	stamina.stamina_replenished.connect(_on_stamina_regen)

func _think():
	pass

func _on_stamina_depleted():
	state_machine.change_state(DescendToGroundState.new())
	
func _on_stamina_regen():
	pass
