extends MeshInstance3D


# Declare member variables here. Examples:

var a = 2

@export var speed: float = 10  
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	translate(Vector3.FORWARD * speed * delta)
	
