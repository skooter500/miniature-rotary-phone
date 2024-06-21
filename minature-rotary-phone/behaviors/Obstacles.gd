extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

@export var obstacle_scene:PackedScene

@export var count = 5

@export var radius = 5
@export var bubble_radius = 5 

@export var center_path:NodePath
var center

# Called when the node enters the scene tree for the first time.
func _ready():
	center = get_node(center_path)
	for i in count:
		var o = obstacle_scene.instantiate()		
		add_child(o)
		var pos = Utils.random_point_in_unit_sphere() * radius		
		o.global_transform.origin = pos
		o.global_transform.basis = Basis(Vector3.UP, randf_range(0, PI * 2.0))
		var constrain = o.find_child("Constrain", true)
			
		constrain.center = center
		constrain.radius = radius
		o.global_transform.basis = o.global_transform.basis.scaled(Vector3(bubble_radius, bubble_radius, bubble_radius))		
		
	pass
