extends Node3D

var butterfly_scene = preload("res://map/butterfly/butterfly.tscn")
var amount = 0
var butterflies = []

# Called when the node enters the scene tree for the first time.
func _ready():
	Parameters.connect("BUTTERFLY_SPAWN", spawn_butterflies)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func spawn_butterflies(new_value):
	var current_value = butterflies.size()
	if new_value > current_value:
		spawn_additional_butterflies(new_value - current_value)
	elif new_value < current_value:
		remove_excess_butterflies(current_value - new_value)

func spawn_additional_butterflies(count):
	for i in range(count):
		var butterfly = butterfly_scene.instantiate()
		butterfly.transform.origin.y += randi_range(1500, 2000);
		butterfly.transform.origin.x += randi_range(-2000, 2000);
		butterfly.transform.origin.z += randi_range(-2000, 2000);
		add_child(butterfly)
		butterflies.append(butterfly)

func remove_excess_butterflies(count):
	for i in range(count):
		if butterflies.size() > 0:
			var last_butterfly = butterflies.pop_back()
			remove_child(last_butterfly)
			last_butterfly.queue_free()


