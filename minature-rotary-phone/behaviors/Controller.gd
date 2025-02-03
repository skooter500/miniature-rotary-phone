extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var harmonic
@onready var direction = get_node("GridContainer2/OptionButton")
# Called when the node enters the scene tree for the first time.
func _r667eady():
	harmonic =  get_node("../../creature/boid/Harmonic")
	direction.add_item("Horizontal")
	direction.add_item("Vertical")
	$GridContainer2/distance.value = harmonic.distance
	$GridContainer2/radius.value = harmonic.radius
	$GridContainer2/amplitude.value = harmonic.amplitude
	$GridContainer2/Frequency.value = harmonic.frequency
	$GridContainer2/weight.value = harmonic.weight
	
	$GridContainer2/damping.value = $"../../creature/spineanimator".damping
	$GridContainer2/angularDamping.value = $"../../creature/spineanimator".damping
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_distance_value_changed(value):
	
	harmonic.distance = value
	pass # Replace with function body.


func _on_radius_value_changed(value):
	print(value)
	
	harmonic.radius = value
	pass # Replace with function body.


func _on_amplitude_value_changed(value):
	print(value)
	
	harmonic.amplitude = value
	pass # Replace with function body.


func _on_Frequency_value_changed(value):
	print(value)
	
	harmonic.frequency = value
	pass # Replace with function body.


func _on_weight_value_changed(value):
	print(value)
	
	harmonic.weight = value
	pass # Replace with function body.


func _on_damping_value_changed(value):
	print(value)
	
	$"../../creature/spineanimator".damping = value	
	pass # Replace with function body.


func _on_angularDamping_value_changed(value):
	print(value)
	$"../creature/spineanimator".angular_damping = value
	pass # Replace with function body.


func _on_option_button_item_selected(index: int) -> void:
	harmonic.axis = index
	pass # Replace with function body.


func _on_angular_damping_value_changed(value: float) -> void:
	pass # Replace with function body.
