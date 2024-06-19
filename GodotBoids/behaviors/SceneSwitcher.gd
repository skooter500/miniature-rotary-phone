class_name SceneSwitcher
extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


@export var scenes: Array[String] = []

static var current_scene = 0
static var current_scene_name

# Called when the node enters the scene tree for the first time.
func _ready():
	print("Current Scene: " + str(current_scene))
	current_scene_name = scenes[current_scene]
	pass # Replace with function body.

func _input(event):
	if event is InputEventKey and event.pressed and ! event.echo:
		if event.keycode == KEY_Q:
			get_tree().quit()
		if event.keycode == KEY_N:
			if current_scene > 0:
				current_scene -= 1
			else:
				current_scene = scenes.size() - 1
			get_tree().change_scene_to_file(scenes[current_scene])
			return
		# print(event.keycode)
		if event.keycode == KEY_M:
			current_scene = (current_scene + 1) % scenes.size()
			get_tree().change_scene_to_file(scenes[current_scene])
			return
		current_scene = event.keycode - KEY_0
		if event.keycode >= KEY_0 and current_scene >= 0 and current_scene < scenes.size():			
			get_tree().change_scene_to_file(scenes[current_scene])
