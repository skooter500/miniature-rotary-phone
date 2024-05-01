extends Button

@export
var parent: CanvasItem

func _ready() -> void:
	pressed.connect(_on_pressed)

func _on_pressed() -> void:
	parent.hide()
