extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
# Called when the node enters the scene tree for the first time.

func configure_scene():
	var b = $"../School/Boid"
	$"../camera follower/offset_pursue".leader_boid = b
	
	$"../Player/Camera3D/Camera3D Controller".boid = b 
func _ready():
	configure_scene()
	pass # Replace with function body
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
