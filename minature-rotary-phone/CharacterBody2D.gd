extends CharacterBody2D

func _process(delta):
	position.x += randf_range(-50.0, 50.0)
	position.y += randf_range(-50, 50)
