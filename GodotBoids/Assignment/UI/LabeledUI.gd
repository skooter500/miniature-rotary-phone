@tool

extends VBoxContainer

class_name LabeledUI

@export 
var label: Label

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

func _ready() -> void:
	update_property(label, "text", text)

func update_property(node: Node, property_name, value):
	if node != null:
		node.set(property_name, value)
