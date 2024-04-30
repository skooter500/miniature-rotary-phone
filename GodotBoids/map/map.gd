extends Node3D

@onready var flower = get_node("Nature/Clump4/Clump4_GRADIENT_0").global_transform

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# tell butterflies where the flowers are
	Parameters.FLOWER_POSITION.emit(flower)
