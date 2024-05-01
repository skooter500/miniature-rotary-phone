extends Node3D

var laserBullet
var timer : Timer

@export var timer_delay : float
var laserBallTimer = Timer.new()
var hasTimerStarted = false

# Called when the node enters the scene tree for the first time.
func _ready():
	laserBullet = load("res://robot/laser_bullet.tscn")
	
	laserBallTimer.wait_time = timer_delay
	
	laserBallTimer.timeout.connect(_on_laserBallTimer_timeout)
	
	add_child(laserBallTimer)

	# timer.wait_time = 5.0
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_visible_in_tree():
		if hasTimerStarted == false:
			laserBallTimer.start()
			hasTimerStarted = true
	


func _on_laserBallTimer_timeout():
	var bullet = laserBullet.instantiate()
	add_child(bullet)
	hasTimerStarted = false
	pass # Replace with function body.
