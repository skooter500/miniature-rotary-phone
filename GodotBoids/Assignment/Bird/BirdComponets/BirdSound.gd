@tool

extends AudioStreamPlayer3D

@export
var timer: Timer

@export_range(0,120)
var min: float = 30:
	set(value):
		max = max(max,value)
		min = value
@export_range(0,120)
var max: float = 60:
	set(value):
		max = max(min, value)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.timeout.connect(_timeout)
	timer.start(randf_range(min, max))

func _timeout():
	play()
	timer.start(randf_range(min, max))
