@tool

extends Node3D

@export_enum("Flying","Walking")
var state: String = "Walking"
@export
var wing1: Wing
@export
var wing2: Wing
@export
var body: Node3D

var tween: Tween 
var current_state: String = "Walking"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if state == current_state:
		return
	match state:
		"Flying":
			transition_to_flying()
		"Walking":
			transition_to_walking()
		_:
			print("Unsupported body state. Please make sure that ",state," is a supported state") 
	
func transition_to_walking():
	pass
	
func transition_to_flying():
	pass
