class_name RetreatState extends State

var boid
var target
var target_pos

func _enter():
	target = get_tree().get_current_scene().find_child("AttackerBase")
	target_pos = target.global_position
	boid.get_node("Seek").target = target
	boid.get_node("Seek").set_enabled(true)
	boid.get_node("Sounds").play_sound(1)

func _exit():
	boid.get_node("Seek").set_enabled(false)
	pass

func _think():		
	if target_pos.distance_to(boid.global_transform.origin) < 5:		
		# See: https://www.reddit.com/r/godot/comments/hu213d/class_was_found_in_global_scope_but_its_script/		
		# boid.get_node("StateMachine").change_state(AttackState.new())
		var AttackState = load("res://behaviors/AttackState.gd")
		boid.get_node("StateMachine").change_state(AttackState.new())

		pass
		
#func get_class():
#	return "RetreatState"
	
func _ready():
	boid = get_parent()
	pass
