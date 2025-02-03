class_name CameraController

extends Node

# var a = 2
# var b = "text"

@onready var player = get_node("../..")
@export var boid_player:Boid
@export var boid:Boid

enum Mode { Free, Follow, Boid}

@export var mode = Mode.Free

var left:XRController3D
var right:XRController3D

# Called when the node enters the scene tree for the first time.
func _ready():
	
	#left = $"../../XROrigin3D/left"
	
	# right = $"../../XROrigin3D/right"

	boid_player = get_tree().current_scene.find_child("camera follower")
	
	if !boid:
		boid = get_tree().current_scene.find_child("boid")
	
	call_deferred("calculate_offset")
	call_deferred("set_mode", mode)

func calculate_offset():
	boid_player.get_node("offset_pursue").calculate_offset()
	
func set_mode(mode):
	self.mode = mode
	match mode:
		Mode.Follow:
			player.can_move = false	
			boid_player.transform.origin = player.transform.origin
			call_deferred("calculate_offset") 
			boid_player.draw_gizmos_recursive(false)
		Mode.Boid:
			player.can_move = false	
			boid.find_child("MeshInstance3D").set_visible(false)
			boid_player.draw_gizmos_recursive(true)
		Mode.Free:
			boid.find_child("MeshInstance3D").set_visible(true)				
			player.can_move = true			
			boid_player.draw_gizmos_recursive(true)
	
func toggle():
	set_mode((mode + 1) % Mode.keys().size())
			
		
func _input(event):
	if event is InputEventKey and event.keycode == KEY_C and event.pressed:
		toggle()
						
func _physics_process(delta):
	match mode:
		Mode.Follow:	
			player.global_transform.origin = lerp(player.global_transform.origin, boid_player.global_transform.origin, delta * 10.0)
			var desired = player.global_transform.looking_at(boid.global_transform.origin, Vector3.UP)		
			player.global_transform.basis = player.global_transform.basis.slerp(desired.basis, delta * 2).orthonormalized()
		Mode.Boid:
			player.global_transform.origin = lerp(player.global_transform.origin, boid.global_transform.origin, delta * 5.0)
			var desired = player.global_transform.looking_at(boid.global_transform.origin + boid.global_transform.basis.z , Vector3.UP)
			player.global_transform.basis = player.global_transform.basis.slerp(desired.basis, delta * 5).orthonormalized()
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
