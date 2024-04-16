extends Node3D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

@export var count = 50

@export var radius = 200

var fishScene

# Called when the node enters the scene tree for the first time.
func _ready():
	fishScene = load("res://creature.tscn")
	
	for i in count:
		var fish = fishScene.instantiate()
		var pos = Utils.random_point_in_unit_sphere() * radius
		fish.transform.origin = pos
		add_child(fish)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
