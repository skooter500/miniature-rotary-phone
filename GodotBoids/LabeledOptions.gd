@tool

extends LabeledUI

class_name LabeledOptions

@export
var options_button: OptionButton
@export
var options: Array[String] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	options_button.clear()
	for option in options:
		options_button.add_item(option)
	options_button.item_selected.connect(_on_item_selected)

func _on_item_selected(index):
		Parameters.emit_signal(signal_to_notify, node_name, propery_name, index)
