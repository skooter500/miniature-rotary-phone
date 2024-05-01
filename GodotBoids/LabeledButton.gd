@tool

extends LabeledUI

class_name LabeledButton

@export 
var button: Button
@export
var button_text: String = "Placeholder":
	set(value):
		update_property(button, "text", value)
		button_text = value

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	update_property(button, "text", button_text)	
	button.pressed.connect(_on_press)

func _on_press():
	Parameters.emit_signal(signal_to_notify, node_name, propery_name, true)
