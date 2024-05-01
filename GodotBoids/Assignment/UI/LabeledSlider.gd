@tool

extends VBoxContainer

class_name LabeledSlider

@export
var text: String = "Placeholder":
	set(value):
		update_property(label, "text", value)
		text = value
@export
var signal_to_notify: String
@export
var node_name: String
@export
var propery_name: String

@export_category("Slider")
@export
var min_value: float = 0:
	set(value):
		update_property(slider, "min_value", value)
		min_value = value
@export
var max_value: float = 100:
	set(value):
		update_property(slider, "max_value", value)
		max_value = value
@export
var step: float = 1:
	set(value):
		step = snapped(value, 0.01)
		update_property(slider, "step", value)
@export
var value: float = 0:
	set(new_value):
		value = snapped(clamp(new_value, min_value, max_value),step)
		update_property(slider, "value", value)
		update_property(value_label, "text", value)

@onready 
var label: Label = $Label
@onready
var slider: HSlider = $HBoxContainer/HSlider
@onready
var value_label: Label = $HBoxContainer/Value

func _ready() -> void:
	update_property(label, "text", text)
	update_property(slider, "min_value", min_value)
	update_property(slider, "max_value", max_value)
	update_property(slider, "step", step)
	update_property(slider, "value", value)
	update_property(value_label, "text", value)
	slider.value_changed.connect(value_changed)

func update_property(node: Node, property_name, value):
	if node != null:
		node.set(property_name, value)

func value_changed(slide_value):
	value = snapped(slide_value,step)
	Parameters.emit_signal(signal_to_notify, node_name, propery_name, slide_value)
