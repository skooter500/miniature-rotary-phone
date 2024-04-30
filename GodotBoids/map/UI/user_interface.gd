extends Node3D

@onready var UI = $"."
@onready var pov = $"Camera3D"
@export var mouse_sensitivity = 0.15
@export var movement_speed = 150.0 
var toggle_mouse = false

# parameters
@onready var butterfly_amount = $CanvasLayer/Control/butterfly_amount
@onready var butterfly_speed = $CanvasLayer/Control/butterfly_speed
var previous_butterfly_amount = 0
var previous_butterfly_speed = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	previous_butterfly_amount = butterfly_amount.get_value()
	previous_butterfly_speed = butterfly_speed.get_value()

# for camera movement
func _input(event):
	if event is InputEventMouseMotion:
		if toggle_mouse == true:
			rotate_y(deg_to_rad(-event.relative.x * mouse_sensitivity))
			pov.rotate_x(deg_to_rad(-event.relative.y * mouse_sensitivity))
			pov.rotation.x = clamp(pov.rotation.x, deg_to_rad(-89), deg_to_rad(89))
		
	if Input.is_action_just_pressed("hide_cursor"):
		if toggle_mouse:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			toggle_mouse = false
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
			toggle_mouse = true
		
func _physics_process(delta):
	var input_direction = Input.get_vector("cam_left", "cam_right", "cam_forward", "cam_backward")
	var rotation = pov.rotation

	# Calculate movement direction relative to camera orientation
	var forward_back = transform.basis.z
	var right_left = transform.basis.x
	var movement_direction = (forward_back * input_direction.y + right_left * input_direction.x).normalized()
	
	if movement_direction.length() > 0:
		# Adjust movement direction based on camera tilt
		var up_direction = Vector3(0, 1, 0)
		var forward_tilt = pov.global_transform.basis.z.dot(up_direction)
		var movement = movement_direction * movement_speed * delta

		# Move camera
		UI.global_transform.origin += movement
		UI.global_transform.origin.y -= forward_tilt * movement_speed * delta
		
	amount_butterfies();
	butterflies_speed();
	

func amount_butterfies():
	var current_amount = butterfly_amount.get_value()
	if current_amount != previous_butterfly_amount:
		print("Butterfly amount changed: ", current_amount)
		previous_butterfly_amount = current_amount
		Parameters.BUTTERFLY_SPAWN.emit(current_amount)

func butterflies_speed():
	var current_speed = butterfly_speed.get_value()
	if current_speed != previous_butterfly_speed:
		print("Butterfly speed changed: ", current_speed)
		previous_butterfly_speed = current_speed
		Parameters.BUTTERFLY_SPEED.emit(current_speed)
		

