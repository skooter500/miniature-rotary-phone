class_name Root extends Node3D

var custom_font:Font 

func _input(event):
	if event is InputEventKey and event.pressed and event.keycode == KEY_F:
		if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)

func on_draw_gizmos():
	var size = 5000
	var sub_divisions = size / 100
	DebugDraw3D.draw_grid(Vector3.ZERO, Vector3.RIGHT* size, Vector3.BACK * size, Vector2(sub_divisions, sub_divisions), Color.WHITE)
	
	# DebugDraw.draw_grid(Vector3.ZERO, Vector3.UP * size, Vector3.BACK * size, Vector2(sub_divisions, sub_divisions), Color.aquamarine)
	# DebugDraw.draw_grid(Vector3.ZERO, Vector3.RIGHT* size, Vector3.BACK * size, Vector2(sub_divisions, sub_divisions), Color.AQUAMARINE)

var xr_interface: XRInterface

var text_size = 30

func _ready():
	custom_font = load("res://fonts/Hyperspace Bold.otf")
	DebugDraw2D.config.text_custom_font = custom_font
	DebugDraw2D.config.text_default_size = text_size
	DebugDraw2D.config.text_background_color = Color.TRANSPARENT
	#DebugDraw2D.config.text_foreground_color = Color.CHARTREUSE
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
