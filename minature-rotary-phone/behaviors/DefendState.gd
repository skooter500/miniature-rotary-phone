class_name DefendState extends State

var boid

@onready var enemy = get_node("../../Attacker")

#func get_class():
#	return "DefendState"

# Called when the node enters the scene tree for the first time.
func _ready():
	boid = get_parent()
	pass # Replace with function body.


func _enter():
	boid.set_enabled_all(false)
	# boid.get_node("Wander").set_enabled(true)
	boid.get_node("Seek").set_enabled(true)
	boid.get_node("Seek").target = enemy
	boid.get_node("Sounds").play_sound(1)

func _exit():
	boid.get_node("Seek").target = null
	boid.get_node("Seek").set_enabled(false)
	
func _think():
	var to_enemy = enemy.global_transform.origin - boid.global_transform.origin
	DebugDraw2D.set_text("To attacker", to_enemy.length())
	if to_enemy.length() > 120:
		boid.get_node("StateMachine").change_state(ReturnToBase.new())
		pass	
