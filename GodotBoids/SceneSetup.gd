extends Node3D

@export
var default_bird: Node3D
@export
var camera_controller: CameraController
@export
var camera_pursue: OffsetPursue

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var boid = default_bird.find_child("Boid")
	camera_controller.boid = boid
	camera_pursue.leader_boid = boid

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
