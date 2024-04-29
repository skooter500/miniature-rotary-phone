extends Node

@export
var birds: Node3D
@export
var camera_controller: CameraController
@export
var camera_pursue: OffsetPursue

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if birds.get_child_count() <= 0:
		return
	var bird = birds.get_child(0)
	if not bird is Boid:
		bird = bird.find_child("Boid")
	camera_controller.boid = bird
	camera_pursue.leader_boid = bird

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
