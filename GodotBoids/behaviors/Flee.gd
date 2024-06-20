class_name Flee extends SteeringBehavior

@export var enemy_path:NodePath
var enemy_boid:Node

@export var flee_range = 50

var force = Vector3.ZERO

func on_draw_gizmos():
	DebugDraw3D.draw_sphere(boid.global_transform.origin, flee_range, Color.DARK_SALMON)
	
	if force != Vector3.ZERO:
		DebugDraw3D.draw_arrow(boid.global_transform.origin, enemy_boid.global_transform.origin, Color.DARK_SALMON)

func calculate():
	var to_enemy = enemy_boid.global_transform.origin - boid.global_transform.origin
	DebugDraw2D.set_text("to_enemy", to_enemy.length())
	if to_enemy.length() < flee_range:
		to_enemy = to_enemy.normalized()
		var desired = to_enemy * boid.max_speed
		return boid.velocity - desired 
	else:
		return Vector3.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	boid = get_parent()
	if enemy_path:
		enemy_boid = get_node(enemy_path)
