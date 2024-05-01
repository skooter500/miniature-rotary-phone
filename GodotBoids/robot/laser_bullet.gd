extends Node3D

@export var speed : float
var bulletTimer = Timer.new()
# Called when the node enters the scene tree for the first time.
func _ready():
	bulletTimer.wait_time = 1.0
	bulletTimer.timeout.connect(_on_bulletTimer_timeout)
	
	bulletTimer.one_shot = true
	
	add_child(bulletTimer)
	
	
	bulletTimer.start()
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	translate(Vector3(0, speed * delta, 0))
	pass


func _on_bulletTimer_timeout():
	print("Should be deleting")
	queue_free()
