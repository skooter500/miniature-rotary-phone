extends Node3D

func on_draw_gizmos():
	var size = 5000
	var sub_divisions = size / 100
	DebugDraw3D.draw_grid(Vector3.ZERO, Vector3.RIGHT* size, Vector3.BACK * size, Vector2(sub_divisions, sub_divisions), Color.AQUAMARINE)
	
	# DebugDraw.draw_grid(Vector3.ZERO, Vector3.UP * size, Vector3.BACK * size, Vector2(sub_divisions, sub_divisions), Color.aquamarine)
	# DebugDraw.draw_grid(Vector3.ZERO, Vector3.RIGHT* size, Vector3.BACK * size, Vector2(sub_divisions, sub_divisions), Color.AQUAMARINE)


var xr_interface: XRInterface

func _ready():
	xr_interface = XRServer.find_interface("OpenXR")
	if xr_interface and xr_interface.is_initialized():
		print("OpenXR initialised successfully")

		# Turn off v-sync!
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)

		# Change our main viewport to output to the HMD
		get_viewport().use_xr = true
	else:
		print("OpenXR not initialized, please check if your headset is connected")
	get_window().set_current_screen(1)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	on_draw_gizmos()

