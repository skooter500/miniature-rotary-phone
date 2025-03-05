class_name Root extends Node3D

var custom_font:Font 

var environment:Environment

var passthrough_enabled: bool = false


func _input(event):
	if event is InputEventKey and event.pressed and event.keycode == KEY_F:
		if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)

func on_draw_gizmos():
	var size = 5000
	var sub_divisions = size / 100
	# DebugDraw3D.draw_grid(Vector3.ZERO, Vector3.RIGHT* size, Vector3.BACK * size, Vector2(sub_divisions, sub_divisions), Color.WHITE)
	
	# DebugDraw.draw_grid(Vector3.ZERO, Vector3.UP * size, Vector3.BACK * size, Vector2(sub_divisions, sub_divisions), Color.aquamarine)
	# DebugDraw.draw_grid(Vector3.ZERO, Vector3.RIGHT* size, Vector3.BACK * size, Vector2(sub_divisions, sub_divisions), Color.AQUAMARINE)

var xr_interface: XRInterface

var text_size = 30

	
func _scene_data_missing() -> void:
	scene_manager.request_scene_capture()

func _scene_capture_completed(success: bool) -> void:
	if success == false:
		return

	# Delete any existing anchors, since the user may have changed them.
	if scene_manager.are_scene_anchors_created():
		scene_manager.remove_scene_anchors()

	# Create scene_anchors for the freshly captured scene
	scene_manager.create_scene_anchors()


func _ready():
	scene_manager.openxr_fb_scene_data_missing.connect(_scene_data_missing)
	scene_manager.openxr_fb_scene_capture_completed.connect(_scene_capture_completed)

	environment = $WorldEnvironment.environment
	custom_font = load("res://fonts/Hyperspace Bold.otf")
	DebugDraw2D.config.text_custom_font = custom_font
	DebugDraw2D.config.text_default_size = text_size
	DebugDraw2D.config.text_background_color = Color.TRANSPARENT
	DebugDraw3D.scoped_config().set_thickness(0.001)
	#DebugDraw2D.config.text_foreground_color = Color.CHARTREUSE
	xr_interface = XRServer.find_interface("OpenXR")
	if xr_interface and xr_interface.is_initialized():
		print("OpenXR initialised successfully")

		# Turn off v-sync!
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)

		# Change our main viewport to output to the HMD
		get_viewport().use_xr = true
		var modes = xr_interface.get_supported_environment_blend_modes()
		if XRInterface.XR_ENV_BLEND_MODE_ALPHA_BLEND in modes:
			xr_interface.environment_blend_mode = XRInterface.XR_ENV_BLEND_MODE_ALPHA_BLEND
		elif XRInterface.XR_ENV_BLEND_MODE_ADDITIVE in modes:
			xr_interface.environment_blend_mode = XRInterface.XR_ENV_BLEND_MODE_ADDITIVE
		else:
			print("ARGH!!!!")
			return false
	else:
		print("OpenXR not initialized, please check if your headset is connected")
	
	get_viewport().transparent_bg = true
	environment.background_mode = Environment.BG_CLEAR_COLOR
	environment.ambient_light_source = Environment.AMBIENT_SOURCE_COLOR
	get_window().set_current_screen(1)


	 # get_window().set_current_screen(1)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	on_draw_gizmos()
	# var g = _create_graph(&"FPS", true, false, DebugDrawGraph.TEXT_CURRENT | DebugDrawGraph.TEXT_AVG | DebugDrawGraph.TEXT_MAX | DebugDrawGraph.TEXT_MIN, &"", DebugDrawGraph.SIDE_BOTTOM, DebugDrawGraph.POSITION_LEFT_TOP if Engine.is_editor_hint() else DebugDrawGraph.POSITION_RIGHT_TOP, Vector2i(200, 80), custom_font)
	var g = _create_graph(&"FPS", true, false, DebugDraw2DGraph.TEXT_CURRENT | DebugDraw2DGraph.TEXT_AVG | DebugDraw2DGraph.TEXT_MAX | DebugDraw2DGraph.TEXT_MIN, &"", DebugDraw2DGraph.SIDE_BOTTOM, DebugDraw2DGraph.POSITION_LEFT_TOP if Engine.is_editor_hint() else DebugDraw2DGraph.POSITION_RIGHT_TOP, Vector2i(500, 110), custom_font)
	
	g.frame_time_mode = false

func _create_graph(title, is_fps, show_title, flags, parent := &"", parent_side := DebugDraw2DGraph.SIDE_BOTTOM, pos = DebugDraw2DGraph.POSITION_LEFT_BOTTOM, size := Vector2i(500, 500), font = null) -> DebugDraw2DGraph:
	var graph := DebugDraw2D.get_graph(title)
	if !graph:
		if is_fps:
			graph = DebugDraw2D.create_fps_graph(title)
		else:
			graph = DebugDraw2D.create_graph(title)
		
		if graph:
			graph.size = size
			graph.buffer_size = 50
			graph.corner = pos
			graph.show_title = show_title
			graph.show_text_flags = flags
			graph.custom_font = font
			graph.text_color = Color.CHARTREUSE
			graph.background_color = Color.TRANSPARENT
			graph.text_size = text_size
			graph.set_parent(parent, parent_side)
	
	return graph
	
@onready var scene_manager: OpenXRFbSceneManager = $"Player/XROrigin3D/OpenXRFbSceneManager"

var scene_and_spatial_anchors_displayed:bool = true

func enable_passthrough(enable: bool) -> void:
	if passthrough_enabled == enable:
		return

	var supported_blend_modes = xr_interface.get_supported_environment_blend_modes()
	if XRInterface.XR_ENV_BLEND_MODE_ALPHA_BLEND in supported_blend_modes and XRInterface.XR_ENV_BLEND_MODE_OPAQUE in supported_blend_modes:
		if enable:
			# Switch to passthrough.
			xr_interface.environment_blend_mode = XRInterface.XR_ENV_BLEND_MODE_ALPHA_BLEND
			get_viewport().transparent_bg = true
			environment.background_color = Color(0.0, 0.0, 0.0, 0.0)
		else:
			# Switch back to VR.
			xr_interface.environment_blend_mode = XRInterface.XR_ENV_BLEND_MODE_OPAQUE
			get_viewport().transparent_bg = false
			environment.background_color = Color(0.3, 0.3, 0.3, 1.0)
		passthrough_enabled = enable


func _on_left_button_pressed(name: String) -> void:
	print(name)
	if name == "menu_button":
		scene_and_spatial_anchors_displayed = ! scene_and_spatial_anchors_displayed
		scene_manager.visible = scene_and_spatial_anchors_displayed	
	elif name == "select_button":
		enable_passthrough(not passthrough_enabled)
pass # Replace with function body.


func _on_right_button_pressed(name: String) -> void:
	print(name)
	if name == "menu_button":
		scene_manager.request_scene_capture()
	pass # Replace with function body.
