extends CanvasLayer

var cam_controller:CameraController

var label:Label
 
func _ready():
	cam_controller = $"../Player/Camera3D/Camera3D Controller"
	label = $Control/MarginContainer2/Label

func _process(delta):
	var s
	
	s = "Scene: " + str(SceneSwitcher.current_scene_name) + "\n" 
	# s += "Cam:" + str(CameraController.Mode.keys()[cam_controller.mode])
	label.set_text(s)
