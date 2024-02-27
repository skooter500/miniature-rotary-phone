class_name Root extends Node3D

@export var custom_font : Font
@export var zylann_example := false
@export var test_text := true
@export var test_graphs := false
@export var more_test_cases := true
@export var draw_array_of_boxes := false
@export_range(0, 1024) var start_culling_distance := 0.0

@export_group("Text groups", "text_groups")
@export var text_groups_show_hints := true
@export var text_groups_show_stats := true
@export var text_groups_position := DebugDraw2DConfig.POSITION_LEFT_TOP
@export var text_groups_offset := Vector2i(8, 8)
@export var text_groups_padding := Vector2i(3, 1)
@export_range(1, 100) var text_groups_default_font_size := 12
@export_range(1, 100) var text_groups_title_font_size := 14
@export_range(1, 100) var text_groups_text_font_size := 12

@export_category("Graphs")
@export var graph_offset := Vector2i(8, 8)
@export var graph_size := Vector2i(200, 80)
@export_range(1, 100) var graph_title_font_size := 14
@export_range(1, 100) var graph_text_font_size := 12
@export_range(0, 64) var graph_text_precision := 2
@export_range(1, 32) var graph_line_width := 1.0
@export_range(1, 512) var graph_buffer_size := 128
@export var graph_frame_time_mode := true
@export var graph_is_enabled := true

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

	 # get_window().set_current_screen(1)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	on_draw_gizmos()
	# var g = _create_graph(&"FPS", true, false, DebugDrawGraph.TEXT_CURRENT | DebugDrawGraph.TEXT_AVG | DebugDrawGraph.TEXT_MAX | DebugDrawGraph.TEXT_MIN, &"", DebugDrawGraph.SIDE_BOTTOM, DebugDrawGraph.POSITION_LEFT_TOP if Engine.is_editor_hint() else DebugDrawGraph.POSITION_RIGHT_TOP, Vector2i(200, 80), custom_font)
	var g = _create_graph(&"FPS", true, false, DebugDraw2DGraph.TEXT_CURRENT | DebugDraw2DGraph.TEXT_AVG | DebugDraw2DGraph.TEXT_MAX | DebugDraw2DGraph.TEXT_MIN, &"", DebugDraw2DGraph.SIDE_BOTTOM, DebugDraw2DGraph.POSITION_LEFT_TOP if Engine.is_editor_hint() else DebugDraw2DGraph.POSITION_RIGHT_TOP, Vector2i(200, 80), custom_font)
	
	g.frame_time_mode = false

func _create_graph(title, is_fps, show_title, flags, parent := &"", parent_side := DebugDraw2DGraph.SIDE_BOTTOM, pos = DebugDraw2DGraph.POSITION_LEFT_BOTTOM, size := Vector2i(256, 60), font = null) -> DebugDraw2DGraph:
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
			graph.set_parent(parent, parent_side)
	
	return graph

