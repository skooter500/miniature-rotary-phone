class_name State extends Node


var boid: Boid
var state_machine: StateMachine

func _enter():
	pass

func _exit():
	pass
	
func _think():
	pass
 

# Called when the node enters the scene tree for the first time.
func _ready():
	boid = get_parent()
	state_machine = boid.find_child("StateMachine")

func change_behaviour(behaviour_name: String, new_state: bool):
	var behaviour = boid.find_child(behaviour_name)
	if behaviour != null:
		behaviour.enabled = new_state
