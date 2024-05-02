extends State

class_name BirdGlobalState

@export
var stamina: Stamina
@export
var robot: Node3D

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
	var flee: Flee = boid.find_child("Flee")
	if robot and robot.global_position.distance_to(boid.global_position) < flee.flee_range and state_machine.current_state is GroundState:
		state_machine.change_state(TakeOffState.new())

func _on_stamina_depleted():
	pass
	
func _on_stamina_regen():
	pass
