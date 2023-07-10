extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
# Called when the node enters the scene tree for the first time.
func _ready():
	$"../../camera follower/OffsetPursue".leader_node_path = "../../School/Boid"
	$"../../Player/Camera3D/Camera3D Controller".boid_path = "../../../School/Boid"
	
	pass # Replace with function body
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
