extends Boid

@export_category("Behaviours")
@export
var centre_point: Marker3D

@onready
var boid: Boid = $Boid
@onready
var body = $Boid/MeshInstance3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
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
