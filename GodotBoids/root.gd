extends Node3D

@export var custom_font : Font


func draw_gizmos():
	var size = 100
	var sub_divisions = 10
	DebugDraw.draw_grid(Vector3.ZERO, Vector3.RIGHT* size, Vector3.BACK * size, Vector2(sub_divisions, sub_divisions), Color.AQUAMARINE)
	# DebugDraw.draw_grid(Vector3.ZERO, Vector3.UP * size, Vector3.BACK * size, Vector2(sub_divisions, sub_divisions), Color.aquamarine)
	# DebugDraw.draw_grid(Vector3.ZERO, Vector3.RIGHT* size, Vector3.BACK * size, Vector2(sub_divisions, sub_divisions), Color.AQUAMARINE)


func _ready():
	get_window().set_current_screen(0)
	var screen_size = DisplayServer.screen_get_size()
	var window_size = get_window().get_size()
	
	get_window().set_position(screen_size*0.5 - window_size*0.5) 	
	# DebugDraw.tex = custom_font
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	draw_gizmos()
	var g = _create_graph(&"FPS", true, false, DebugDrawGraph.TEXT_CURRENT | DebugDrawGraph.TEXT_AVG | DebugDrawGraph.TEXT_MAX | DebugDrawGraph.TEXT_MIN, &"", DebugDrawGraph.SIDE_BOTTOM, DebugDrawGraph.POSITION_LEFT_TOP if Engine.is_editor_hint() else DebugDrawGraph.POSITION_RIGHT_TOP, Vector2i(200, 80), custom_font)
	g.buffer_size = 300

func _create_graph(title, is_fps, show_title, flags, parent := &"", parent_side := DebugDrawGraph.SIDE_BOTTOM, pos = DebugDrawGraph.POSITION_LEFT_BOTTOM, size := Vector2i(256, 60), font = null) -> DebugDrawGraph:
	var graph := DebugDraw.get_graph(title)
	if !graph:
		if is_fps:
			graph = DebugDraw.create_fps_graph(title)
		else:
			graph = DebugDraw.create_graph(title)
		
		if graph:
			graph.size = size
			graph.buffer_size = 50
			graph.corner = pos
			graph.show_title = show_title
			graph.show_text_flags = flags
			graph.custom_font = font
			graph.set_parent(parent, parent_side)
	
	return graph

