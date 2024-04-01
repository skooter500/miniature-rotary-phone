extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var sounds = []

# Called when the node enters the scene tree for the first time.
func _ready():
	sounds = get_children()
	pass # Replace with function body.

func play_sound(i):
	if i < sounds.size():
		# sounds[i].pitch_scale = rand_range(0.5, 1.5)		
		sounds[i].play()
		pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
