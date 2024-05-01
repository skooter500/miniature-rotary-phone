extends Node3D


var isTrigger = false

var currentState: int
var triggered = true

var canShoot = false

@export var pursueColor : Color
@export var wanderColor: Color
@export var shootColor : Color

@export var murderNode : Node3D

var robotMesh : MeshInstance3D
var eyeMat : StandardMaterial3D
var pursue 
var constrain
var birds 

@export var laserbeamL : Node3D
@export var laserbeamR : Node3D
# Called when the node enters the scene tree for the first time.
func _ready():
	laserbeamL.visible = false
	laserbeamR.visible = false
	currentState = 0
	robotMesh = find_child("EnemyVer2")
	pursue = find_child("Pursue")
	# constrain = find_child("Constrain")
	
	
	eyeMat = robotMesh.get_surface_override_material(1)
	
	_findBirds()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_checkDistance()
	
	if isTrigger:
		eyeMat.emission = pursueColor
	
	else:
		eyeMat.emission = wanderColor
	

func _findBirds():
	
	var murder = get_node("../Murder")
	#
	if murder.get_child_count() > 0:
		birds = murder.get_child(0)
		pursue.enemy_boid = birds
		#pursue.enemyNodePath = 
		isTrigger = true
		print("Birds found")
	else:
		isTrigger = false
		print("No birds found")
		

# Funciton to check the nearest distance to the bird and shoot
func _checkDistance():
	
	if global_transform.origin.distance_to(birds.global_transform.origin) < 40:
		canShoot = true
	else:
		canShoot = false
