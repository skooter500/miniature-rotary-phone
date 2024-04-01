extends Marker3D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

@export var radius = 100

func moveTarget():
	var new_target = Utils.random_point_in_unit_sphere() * radius
	global_transform.origin = new_target


# Called when the node enters the scene tree for the first time.
func _ready():
	moveTarget()


func _on_Timer_timeout():
	moveTarget()

