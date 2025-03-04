extends Node3D

# @onready var player:RigidBody3D = $"../../.."

@onready var flames:GPUParticles3D = $GPUParticles3D
@onready var audio:AudioStreamPlayer3D = $AudioStreamPlayer3D
@export  var xr_controller:XRController3D

@export var power = 100.0

@export var trigger = 0.0

var player

func _ready():
	player = $"../.."
	pass

var lerped_trigger = 0.0

func _physics_process(delta):
	# nprint(delta)
	#if trigger > 0:
		#flames.emitting = true
	#else:
		#flames.emitting = false
	lerped_trigger = lerp(lerped_trigger, trigger, delta * 5.0)
	if lerped_trigger > 0.1:	
		#if not audio.playing:
			#audio.play()
		#audio.volume_db = remap(lerped_trigger, 0, 1, -80, 20)
		var force = - global_transform.basis.y * power * trigger
		player.apply_force(-force, Vector3.ZERO)
		# xr_controller.trigger_haptic_pulse("Haptic", 300 * lerped_trigger, 1, delta, 0)
	#else:
		#audio.stop()

func _on_xr_controller_3d_input_float_changed(name, value):
	if name == "trigger":
		trigger =  value
#	
	pass # Replace with function body.
