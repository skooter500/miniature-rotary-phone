extends CharacterBody3D

@export var mass = 1
@export var force = Vector3.ZERO
@export var acceleration = Vector3.ZERO
@export var speed:float
@export var max_speed: float = 10.0

@export var seekEnabled = false
@export var seekTarget: Vector3

@export var targetNodePath:NodePath

var targetNode:Node

@export var arriveEnabled = false
@export var arriveTarget: Vector3
@export var slowingDistance = 35

@export var banking = 0.1

@export var pathFollowEnabled = false
var pathIndex = 0
var path:Path3D
var waypointSeekDistance = 2

@export var pursueEnabled = false
@export var enemyNodePath:NodePath
var enemyBoid:Node
var pursueTarget:Vector3

@export var offsetPursueEnabled = false
@export var leaderNodePath:NodePath
var leaderBoid:Node
var leaderOffset:Vector3

@export var controllerSteeringEnabled = false
@export var power = 30

@export var drawGizmos = false

@export var jitterWanderEnabled = false
@export var distance:float = 20
@export var radius:float  = 10
@export var jitter:float = 10
var wanderTarget:Vector3

func on_draw_gizmos():
	
	# DebugDraw.draw_line(transform.origin,  transform.origin + transform.basis.z * 10.0 , Color(0, 0, 1))
	#DebugDraw.draw_line(transform.origin,  transform.origin + transform.basis.x * 10.0 , Color(1, 0, 0))
	#DebugDraw.draw_line(transform.origin,  transform.origin + transform.basis.y * 10.0 , Color(0, 1, 0))
	DebugDraw3D.draw_line(transform.origin, transform.origin + (force * 20), Color(1, 1, 0))
	
	if pursueEnabled:
		DebugDraw3D.draw_sphere(pursueTarget, 1, Color.RED)
	
	if (arriveEnabled):
		DebugDraw3D.draw_sphere(targetNode.position, slowingDistance, Color.BLUE_VIOLET)

func jitterWander():
	var delta = get_process_delta_time()

	var disp = jitter * Utils.random_point_in_unit_sphere() * delta
	wanderTarget += disp
	wanderTarget.y = 0;
	wanderTarget = wanderTarget.limit_length(radius)
	# print("wanderTarget" + str(wanderTarget))
	var localTarget = (Vector3.FORWARD * distance) + wanderTarget;

	var worldTarget = global_transform * (localTarget)
	# print("world" + str(worldTarget))
	
	var cent = global_transform * (Vector3.FORWARD * distance)
	DebugDraw3D.draw_sphere(cent, radius, Color.DEEP_PINK)
	DebugDraw3D.draw_line(global_transform.origin, cent, Color.YELLOW_GREEN)
	DebugDraw3D.draw_line(cent, worldTarget, Color.BLUE_VIOLET)
	
	DebugDraw3D.draw_sphere(worldTarget, 1)
	var f = worldTarget - global_transform.origin;
	DebugDraw3D.draw_line(global_transform.origin, global_transform.origin + f)
	return f
	

func pursue():
	var toEnemy = enemyBoid.transform.origin - transform.origin	
	var dist = toEnemy.length()	
	var time = dist / max_speed	
	pursueTarget = enemyBoid.transform.origin + enemyBoid.velocity * time	
	return seek(pursueTarget)

# Called when the node enters the scene tree for the first time.
func _ready():	
	randomize()
	var screen_size = DisplayServer.screen_get_size()
	var window_size = get_window().g765et_size()
	10
	# OS.set_window_position(screen_size*0.5 - window_size*0.5)

	if targetNodePath:	
		targetNode = get_node(targetNodePath)
	if pathFollowEnabled:
		path = $"../Path3D"
		
	if pursueEnabled:
		enemyBoid = get_node(enemyNodePath)
	pass	
	if offsetPursueEnabled:
		leaderBoid = get_node(leaderNodePath)
		leaderOffset = (transform.origin) * leaderBoid.transform.basis
	if jitterWanderEnabled:
		wanderTarget = Utils.random_point_in_unit_sphere() * radius	

func seek(target: Vector3):	
	var toTarget = target - transform.origin
	toTarget = toTarget.normalized()
	var desired = toTarget * max_speed
	return desired - velocity

func controllerSteering():
	var projectedRight = transform.basis.x
	projectedRight.y = 0
	projectedRight = projectedRight.normalized()
	var turn = - Input.get_axis("turn_left", "turn_right")
	var move = - Input.get_axis("move_forward", "move_back")
	var force:Vector3
	force += move * transform.basis.z * power
	force += turn * projectedRight * power
	return force	
	
func arrive(target:Vector3):
	var toTarget = target - transform.origin
	var dist = toTarget.length()
	var ramped = (dist / slowingDistance) * max_speed
	var limit_length = min(max_speed, ramped)
	var desired = (toTarget * limit_length) / dist 
	return desired - velocity

func followPath():
	var target = path.transform * (path.get_curve().get_point_position(pathIndex))
	var dist = global_transform.origin.distance_to(target)
	if dist < waypointSeekDistance:
		pathIndex = (pathIndex + 1) % path.get_curve().get_point_count()
	return seek(path.transform * (path.get_curve().get_point_position(pathIndex)))
	
func offsetPursue():
	var worldTarget = leaderBoid.transform.basis * (leaderOffset)
	var dist = transform.origin.distance_to(worldTarget)
	var time = dist / max_speed
	
	var projected = worldTarget + leaderBoid.velocity * time
	
	# DebugDraw.draw_sphere(projected, 1, Color.red)
	
	return arrive(projected)

func calculate():
	var f = Vector3.ZERO
	if seekEnabled:
		seekTarget = targetNode.transform.origin	
		f += seek(seekTarget)
	if arriveEnabled:
		arriveTarget = targetNode.transform.origin
		f += arrive(arriveTarget)
	if (pathFollowEnabled):
		f += followPath()
	if pursueEnabled:
		f += pursue()
	if offsetPursueEnabled:
		f += offsetPursue()
	if controllerSteeringEnabled:
		f += controllerSteering()
	if jitterWanderEnabled:
		f += (jitterWander())
	return f
	
func _physics_process(delta):			
	force = calculate()
	acceleration = force / mass
	velocity += acceleration * delta
	speed = velocity.length()
	if speed > 0:
		velocity = velocity.limit_length(max_speed)
		# To move a Spatial use any of these:
		# transform.origin += velocity * delta
		# translation += velocity * delta 		
		# global_translate(velocity * delta)		
		
		# print(theta)
		# rotation = Vector3(0, theta, 0)
		# rotate_y(theta)
		# transform.origin += velocity * delta
		
		# move_and_slide(velocity)
		
		# Implement Banking as described:
		# https://www.cs.toronto.edu/~dt/siggraph97-course/cwr87/
		var tempUp = transform.basis.y.lerp(Vector3.UP + (acceleration * banking), delta * 5.0)
		#  look_at(global_transform.origin - velocity, tempUp)
	if drawGizmos:
		on_draw_gizmos()	
	
		
