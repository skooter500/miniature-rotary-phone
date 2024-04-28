extends Node3D

var butterfly_scene = preload("res://map/butterfly/butterfly.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	var amount = 25
	for i in range(amount):
		var butterfly = butterfly_scene.instantiate()
		butterfly.transform.origin.y += 1500
		butterfly.transform.origin.x += randi_range(-2000, 2000);
		butterfly.transform.origin.z += randi_range(-2000, 2000);
		add_child(butterfly)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
