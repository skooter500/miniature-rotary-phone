class_name AttackState extends State

var boid

@onready var pig = get_node("../../pig")
@onready var base = get_node("../../Base")

var target

func _ready():
	boid = get_parent()
	pass

#func get_class():
#	return "AttackState"

func _enter():
	print("Entering attack state")
	boid.set_enabled_all(false)
	boid.get_node("Wander").enabled = true
	boid.get_node("Avoidance").enabled = true
	
	# seek target
	var to_base = base.global_transform.origin - boid.global_transform.origin
	to_base = to_base.normalized()
	target = boid.get_node("Seek").target.global_position	
	boid.get_node("Seek").enabled = true
	boid.get_node("Sounds").play_sound(0)


func _think():
	var to_target = target - boid.transform.origin 
	if to_target.length() < 50:
		boid.get_node("StateMachine").change_state(RetreatState.new())
		pass	
