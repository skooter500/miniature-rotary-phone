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
@export
var claw1: Node3D
@export
var claw2: Node3D
@export
var druation: float = 1
@export
var wing_span: int = 5:
	set(value):
		update_wing_property("num_of_points",value)
		wing_span = value
	get:
		return wing_span

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
			current_state = "Flying"
			transition_to_flying()
		"Walking":
			current_state = "Walking"
			transition_to_walking()
		_:
			print("Unsupported body state. Please make sure that ",state," is a supported state") 

func update_wing_property(property,value):
	wing1.set(property, value)
	wing2.set(property, value)	

func transition_to_walking():
	if (tween == null or not tween.is_running()): 
		tween = get_tree().create_tween()
		tween.set_ease(Tween.EASE_IN)
		tween.set_trans(Tween.TRANS_SINE)
		tween.parallel().tween_property(wing1, "position", Vector3(0,0.071,-0.354), druation)
		tween.parallel().tween_property(wing2, "position", Vector3(0,0.071,-0.354), druation)
		tween.parallel().tween_property(body, "position", Vector3(0,0,0), druation)
		tween.parallel().tween_property(claw1, "position", Vector3(0.05,-1.55,0.45), druation)
		tween.parallel().tween_property(claw2, "position", Vector3(0.8,-1.55,0.45), druation)
		tween.parallel().tween_property(wing1, "rotation_degrees", Vector3(-45,0,0), druation)
		tween.parallel().tween_property(wing2, "rotation_degrees", Vector3(45,180,0), druation)
		tween.parallel().tween_property(body, "rotation_degrees", Vector3(0,0,0), druation)
		tween.parallel().tween_property(claw1, "rotation_degrees", Vector3(0,0,0), druation)
		tween.parallel().tween_property(claw2, "rotation_degrees", Vector3(0,0,0), druation)
		tween.parallel().tween_property(wing1, "num_of_points", 1, druation)
		tween.parallel().tween_property(wing2, "num_of_points", 1, druation)
		tween.play()
	
func transition_to_flying():
	if (tween == null or not tween.is_running()): 
		tween = get_tree().create_tween()
		tween.set_ease(Tween.EASE_IN)
		tween.set_trans(Tween.TRANS_SINE)
		tween.parallel().tween_property(wing1, "position", Vector3(0,1.621,-0.354), druation)
		tween.parallel().tween_property(wing2, "position", Vector3(0,1.621,-0.354), druation)
		tween.parallel().tween_property(body, "position", Vector3(0,1.29,-0.336), druation)
		tween.parallel().tween_property(claw1, "position", Vector3(0.05,-0.1,-1.15), druation)
		tween.parallel().tween_property(claw2, "position", Vector3(0.8,-0.1,-1.15), druation)
		tween.parallel().tween_property(wing1, "rotation_degrees", Vector3(0,0,0), druation)
		tween.parallel().tween_property(wing2, "rotation_degrees", Vector3(0,180,0), druation)
		tween.parallel().tween_property(body, "rotation_degrees", Vector3(45,0,0), druation)
		tween.parallel().tween_property(claw1, "rotation_degrees", Vector3(45,0,0), druation)
		tween.parallel().tween_property(claw2, "rotation_degrees", Vector3(45,0,0), druation)
		tween.parallel().tween_property(wing1, "num_of_points", wing_span, druation)
		tween.parallel().tween_property(wing2, "num_of_points", wing_span, druation)
		tween.play()
