class_name State extends Node


var state_machine

func _enter():
	pass

func _exit():
	pass
	
func _think():
	pass
 

# Called when the node enters the scene tree for the first time.
func _ready():
	state_machine = get_parent()
	pass # Replace with function body.
