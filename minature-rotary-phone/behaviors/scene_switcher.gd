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
		if event.keycode == KEY_COMMA || event.keycode == KEY_LESS :
			if current_scene > 0:
				current_scene -= 1
			else:
				current_scene = scenes.size() - 1
			get_tree().change_scene_to_file(scenes[current_scene])
			return
		if event.keycode == KEY_PERIOD || event.keycode == KEY_GREATER:
			current_scene = (current_scene + 1) % scenes.size()
			print(current_scene)
			print("Changing to: " + scenes[current_scene])
			get_tree().change_scene_to_file(scenes[current_scene])
			return
		
		if event.keycode >= KEY_0 and event.keycode <= KEY_9:
			current_scene = event.keycode - KEY_0			
			get_tree().change_scene_to_file(scenes[current_scene])
