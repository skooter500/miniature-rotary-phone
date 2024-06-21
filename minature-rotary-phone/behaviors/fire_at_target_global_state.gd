class_name FireAtTargetGlobalState extends State

var boid
var bullet_scene:PackedScene
@export var target:Node3D
var timer
var can_fire = true

# Called when the node enters the scene tree for the first time.
func _ready():
	boid = get_parent()
	bullet_scene = load("res://behaviors/bullet1.tscn")
	timer = Timer.new()
	add_child(timer)	
	timer.wait_time = 1
	timer.one_shot = false
	timer.start()
	timer.connect("timeout", Callable(self, "timeout"))	

	
	pass # Replace with function body.

func timeout():
	can_fire = true
	timer.wait_time = randf_range(0.2, 1)

func _enter():
	pass
		
func _think():
	if can_fire:
		var to_target = target.global_transform.origin - boid.global_transform.origin
		var angle = rad_to_deg(boid.global_transform.basis.z.angle_to(to_target))

		var dist = to_target.length()

		if angle < 30 and dist < 100:
			var bullet = bullet_scene.instantiate()
			get_tree().get_current_scene().add_child(bullet)
			bullet.global_transform.origin = boid.global_transform * (Vector3.BACK * 1.3)
			bullet.global_transform.basis = boid.global_transform.basis
			can_fire = false
