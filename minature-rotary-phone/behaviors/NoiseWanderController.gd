extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

@onready var noise_wander = get_node("../creature/boid/NoiseWander")
@onready var fractal_octaves = get_node("fractal_octaves")
@onready var period = get_node("period")
@onready var persistance = get_node("persistance")

@onready var distance = get_node("distance")
@onready var amplitude = get_node("amplitude")
@onready var radius = get_node("radius")


# Called when the node enters the scene tree for the first time.
func _ready():
	fractal_octaves.value = noise_wander.noise.fractal_octaves
	period.value = noise_wander.noise.period
	persistance.value = noise_wander.noise.persistence
	
	distance.value = noise_wander.distance
	radius.value = noise_wander.radius
	amplitude.value = noise_wander.amplitude
	
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_octaves_value_changed(value):
	noise_wander.noise.fractal_octaves = value
	pass # Replace with function body.


func _on_period_value_changed(value):
	noise_wander.noise.period = value
	pass # Replace with function body.


func _on_persistance_value_changed(value):
	noise_wander.noise.persistence = value
	pass # Replace with function body.


func _on_distance_value_changed(value):
	noise_wander.distance = value
	pass # Replace with function body.


func _on_radius_value_changed(value):
	noise_wander.radius = value
	pass # Replace with function body.


func _on_amplitude_value_changed(value):
	noise_wander.amplitude = value
	pass # Replace with function body.
