extends Node3D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

@export var speed:float = - 0.1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	rotate_z(speed * delta)
