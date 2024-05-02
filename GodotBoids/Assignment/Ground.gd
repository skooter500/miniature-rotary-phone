extends StaticBody3D

class_name Ground

var height: float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var collider: CollisionShape3D = get_child(0)
	height = collider.shape.size.y

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
