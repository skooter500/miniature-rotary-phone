extends Button

@export var birdUI: Control

func _ready() -> void:
	pressed.connect(_on_pressed)

func _on_pressed() -> void:
	print("show bird ui")
	birdUI.show()
