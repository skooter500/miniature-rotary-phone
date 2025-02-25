@tool
extends Node3D

@export var length:int=10

@export var start_angle:float = 0
@export var frequency:float = 1
@export var base_size:float = 1
@export var mult:float = 5


@export var head_scene:PackedScene
@export var body_scene:PackedScene

var theta:float = 0
var theta_inc:float = 0

func _process(delta):
	var theta_inc = (PI * 2.0 * frequency) / float(length)
	var z = 0
	for i in length:
		var theta = start_angle +  (i * theta_inc)
		var f = remap(sin(theta), -1, 1, 0, mult)
		DebugDraw2D.set_text(str(f))
		var s = base_size + (f * base_size)		
		# s = base_size
		var cent=Vector3.ZERO
		if i == 0:
			z += s * 0.5
		else:
			z += s *.5
			cent = Vector3(0, 0, -z)
			z += s *.5
		cent = global_transform * cent			
		DebugDraw2D.set_text(str(cent))		
		DebugDraw3D.draw_box(cent, global_transform.basis.get_rotation_quaternion(), Vector3(s, s, s), Color.LIGHT_YELLOW, true)		

func _ready():
	if not Engine.is_editor_hint():		
		var theta_inc = (PI * 2.0 * frequency) / float(length)
		var head
		var spine_animator = SpineAnimator.new()
		var z = 0
		var prev_s = 0
		for i in length:
			var part:Node3D
			var theta = start_angle +  i * theta_inc
			var f = remap(sin(theta), -1, 1, 0, mult)
			var s = base_size + f * base_size		
			# s = base_size
			if i == 0:
				head = head_scene.instantiate()
				part = head
				head.get_node("CSGBox3D").size = Vector3(s, s, s)
				head.position = Vector3.ZERO
				z += s * 0.5
			else:
				part = body_scene.instantiate()
				part.size = Vector3(s, s, s)
				z += s *.5
				part.position = Vector3(0, 0, - z)				
				z += s *.5
				
			spine_animator.bones.push_back(part)
					
			add_child(spine_animator)
			add_child(part)
		spine_animator.calculateOffsets()
	
