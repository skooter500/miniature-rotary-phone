extends Node3D


var isTrigger = false

var currentState: int
var triggered = true

var isCurious = false

var notificationTimer = Timer.new()

var scanningCount = 0


@export var pursueColor : Color
@export var wanderColor: Color
@export var shootColor : Color

@export var murderNode : Node3D

var hasBeenScanned = false

var robotMesh : MeshInstance3D
var eyeMat : StandardMaterial3D
var pursue 
var constrain
var curiosityMarker : Node3D
var notified = false
var timerStarted = false

var groundMarker: Marker3D

var murder
var birds 
var scanner

var birdIndex:int

@export var laserbeamL : Node3D
@export var laserbeamR : Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	birdIndex = 0
	currentState = 0
	robotMesh = find_child("EnemyVer2")
	pursue = get_node("../Pursue")
	curiosityMarker = find_child("CuriosityMarker")
	#scanner = find_child("Scanner")
	constrain = get_node("../Constrain")
	
	_findBirds()
	_setupConstrain()
	
	notificationTimer.wait_time = 1.5
	
	
	notificationTimer.timeout.connect(_on_notificationTimer_timeout)
	
	
	notificationTimer.one_shot = true
	
	add_child(notificationTimer)
	eyeMat = robotMesh.get_surface_override_material(1)
	
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_checkDistance(delta)
	
	if isCurious:
		eyeMat.emission = pursueColor
		
		if not notified and not timerStarted:
			curiosityMarker.visible = true
			notificationTimer.start()
			timerStarted = true
			
		constrain.enabled = false
	else:
		eyeMat.emission = wanderColor
		curiosityMarker.visible = false
		constrain.enabled = true
	
	

func _findBirds():
	murder = get_node("../../Murder")
	if murder.get_child_count() > 0:
		birds = murder.get_child(birdIndex)
		#pursue.enemyNodePath = 
		pursue.enemy_boid = birds
		print("Birds found")
	else:
		print("No birds found")
		

func _setupConstrain():
	groundMarker = get_node("../../GroundMarker")
	constrain.center_path = groundMarker.get_path()


func _on_notificationTimer_timeout():
	print("Pursuing Bird")
	pursue.enabled = true
	notified = true
	curiosityMarker.visible = false
	
# Funciton to check the nearest distance to the bird and shoot
func _checkDistance(delta):
	print("DistanceCheck: " + str(global_transform.origin.distance_to(birds.global_transform.origin)))
	
	if not hasBeenScanned:
		if global_transform.origin.distance_to(birds.global_transform.origin) < 100:
			isCurious = true
			pursue.enabled = true
		
		if global_transform.origin.distance_to(birds.global_transform.origin) > 0 and global_transform.origin.distance_to(birds.global_transform.origin) < 20:
			scanningCount += delta
			print("scannning count" + str(scanningCount))
			
			if scanningCount >= 10:
				isCurious = false
				pursue.enabled = false
				
				if birdIndex < murder.get_child_count() - 1:
					birdIndex += 1
					_findBirds()
					timerStarted = false
				else:
					hasBeenScanned = true
					scanningCount = 0
				
			
		else:
			scanningCount = 0
		
			

