extends Node3D


var isTrigger = false

var currentState: int
var triggered = true

var isCurious = false

@export var pursueColor : Color
@export var wanderColor: Color
@export var shootColor : Color

@export var murderNode : Node3D

var robotMesh : MeshInstance3D
var eyeMat : StandardMaterial3D
var pursue 
var constrain
var curiosityMarker : Node3D

var murder
var birds 

@export var laserbeamL : Node3D
@export var laserbeamR : Node3D
# Called when the node enters the scene tree for the first time.
func _ready():
	currentState = 0
	robotMesh = find_child("EnemyVer2")
	pursue = find_child("Pursue")
	curiosityMarker = find_child("CuriosityMarker")
	# constrain = find_child("Constrain")
	_findBirds()
	
	eyeMat = robotMesh.get_surface_override_material(1)
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_checkDistance()
	
	if isCurious:
		eyeMat.emission = pursueColor
		curiosityMarker.visible = true
	else:
		eyeMat.emission = wanderColor
		curiosityMarker.visible = false
	
	

func _findBirds():
	murder = get_node("../Murder")
	if murder.get_child_count() > 0:
		birds = murder.get_child(0)
		#pursue.enemyNodePath = 
		pursue.enemy_boid = birds
		print("Birds found")
	else:
		print("No birds found")
		

# Funciton to check the nearest distance to the bird and shoot
func _checkDistance():
	if global_transform.origin.distance_to(birds.global_transform.origin) < 100:
		isCurious = true
		pursue.enabled = true
	else:
		isCurious = false
		pursue.enabled = false
