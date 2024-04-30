extends Boid

class_name Bird

@export_category("Behaviours")
@export
var centre_point: Marker3D
@export
var ground: Node3D

@onready
var boid: Boid = $Boid
@onready
var body = $Boid/MeshInstance3D
@onready
var collider: CollisionShape3D = $CollisionShape3D

@export_range(0,360)
var wind_direction: float = 0:
	set(new_value):
		wind_direction_update.emit(new_value)
		wind_direction = new_value
	get:
		return wind_direction

var height: float

signal wind_direction_update(new_direction: float)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	height = collider.shape.size.y+0.5
	#setup_constrain()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	super(delta)
	pass

func setup_constrain() -> void:
	var constrain_node: Constrain = boid.find_child("Constrain")
	if constrain_node == null:
		return
	constrain_node.center_path = centre_point.get_path()
