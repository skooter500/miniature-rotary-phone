@tool

extends Line2D

@export_category("Sin wave")
@export
var amplitude: float = 1.0
@export
var frequency: float = 1.0
@export
var phase_shift: float = 1.0
@export
var vertical_shift: float = 1.0

@export_category("Line")
@export
var num_of_points: int = 10
@export
var dist_between_points: float = 1
@export
var pos: float = 1
@export_range(0.1, 100)
var druation: float = 1
@export
var play_flapping: bool
@export
var invert: bool

var tween: Tween

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (tween == null or not tween.is_running()) and play_flapping: 
		tween = get_tree().create_tween()
		tween.set_ease(Tween.EASE_IN)
		tween.set_trans(Tween.TRANS_BACK)
		tween.tween_property(self, "pos", 1, druation)
		tween.chain().tween_property(self, "pos", -1, druation)
		tween.play()
	draw_sin_line()

func draw_sin_line()-> void:
	clear_points()
	amplitude = pos
	vertical_shift = pos
	for x in range(num_of_points):
		var y = amplitude * sin((x-frequency)/phase_shift)+vertical_shift
		if invert:
			add_point(Vector2(-(x*dist_between_points), y))
		else:
			add_point(Vector2((x*dist_between_points), y))
			
