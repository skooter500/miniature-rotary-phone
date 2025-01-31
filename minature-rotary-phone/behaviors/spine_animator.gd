class_name SpineAnimator extends Node

@export var bones:Array[Node] = []
@export var damping:float = 7
@export var angular_damping:float = 20
				
var offsets = [] 

func calculateOffsets():
	offsets.clear()	
	for i in bones.size():
		if i > 0:
			var offset = bones[i].global_transform.origin - bones[i-1].global_transform.origin
			# offset = bones[i-1].global_transform.basis.xform_inv(offset)
			offset = bones[i-1].global_transform.basis.inverse() * offset
			offsets.push_back(offset)

# Called when the node enters the scene tree for the first time.
func _ready():
	calculateOffsets()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	for i in offsets.size():
		var prev = bones[i]
		var next = bones[i + 1]
		
		var wantedPos = prev.global_transform * (offsets[i])
		
		# Clamp it, cthey dont get too far apart
		var lerped = lerp(next.global_transform.origin, wantedPos, delta * damping)
		var limit_length = (lerped - prev.global_transform.origin).normalized() * offsets[i].length()
		var pos = prev.global_transform.origin + limit_length
		# next.move_and_slide(pos - next.global_transform.origin)
		next.global_transform.origin = pos
		
		var prevRot = prev.global_transform.basis.orthonormalized()
		
		# Why?
		var target_rot = prev.global_transform.looking_at(next.global_transform.origin, prev.global_transform.basis.y).basis.orthonormalized()			
		# var next_rot = nextRot.slerp(prevRot, angular_damping * delta).orthonormalized()		 
		next.global_transform.basis = next.global_transform.basis.slerp(target_rot, angular_damping * delta).orthonormalized()
		
