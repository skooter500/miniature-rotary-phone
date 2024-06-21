extends Marker3D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var original
# Called when the node enters the scene tree for the first time.
func _ready():
	original = transform.origin
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	transform.origin = lerp(transform.origin, original, delta)
