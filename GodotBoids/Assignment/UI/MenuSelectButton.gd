extends Button

@export
var parent: ScrollContainer
@export
var new_menu: ScrollContainer

func _ready() -> void:
	pressed.connect(_on_pressed)

func _on_pressed() -> void:
	parent.hide()
	new_menu.show()
