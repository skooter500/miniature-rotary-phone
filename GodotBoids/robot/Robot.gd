extends Node3D

@export var isTrigger = false

var currentState: int
var triggered = true

var closest_bird : Node3D
var closest_distance : float


@export var pursueColor : Color
@export var wanderColor: Color

var robotMesh : MeshInstance3D
var eyeMat : StandardMaterial3D

@export var laserbeamL : Node3D
@export var laserbeamR : Node3D
# Called when the node enters the scene tree for the first time.
func _ready():
	laserbeamL.visible = false
	laserbeamR.visible = false
	currentState = 0
	robotMesh = get_node("Robot/EnemyVer2")
	eyeMat = robotMesh.get_surface_override_material(1)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if isTrigger:
		eyeMat.emission = pursueColor
		
		if triggered:
			laserbeamL.visible = true
			laserbeamR.visible = true
			triggered = false
	else:
		eyeMat.emission = wanderColor
		laserbeamL.visible = false
		laserbeamR.visible = false
		triggered = false
	
	
	
