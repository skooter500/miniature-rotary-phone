class_name ArriveToFlowers extends SteeringBehavior

@export var target:Node3D
@export var slowing_radius:float = 20 
var flower_pos
var flower_pos2
var current_target

var timer: Timer

# Called when the node enters the scene tree for the first time.
func _ready():
	boid = get_parent()
	Parameters.connect("FLOWER_POSITION", get_position)
	current_target = flower_pos
	Parameters.connect("FLOWER_POSITION2", get_position2)

	timer = Timer.new()
	add_child(timer)
	timer.wait_time = 15  # Set the wait time to 15 seconds
	timer.connect("timeout", switch_flower)
	timer.start()  # Start the timer when the script initializes
	choose_random_target()

func get_position(flower_position):
	flower_pos = flower_position
	
func get_position2(flower_position2):
	flower_pos2 = flower_position2

func switch_flower():
	choose_random_target()
	timer.start()
	
# Choose a random target flower and alternate between them
func choose_random_target():
	var random_number = randi() % 2
	if random_number == 0:
		current_target = flower_pos
	else:
		current_target = flower_pos2
		
func on_draw_gizmos():
	DebugDraw3D.draw_position(flower_pos, Color.AQUAMARINE)
	DebugDraw3D.draw_sphere(flower_pos.origin, slowing_radius, Color.AQUAMARINE)
	
	DebugDraw3D.draw_position(flower_pos2, Color.AQUAMARINE)
	DebugDraw3D.draw_sphere(flower_pos2.origin, slowing_radius, Color.AQUAMARINE)


func calculate():
	if current_target != null:
		return boid.arrive_force(current_target.origin, slowing_radius)
	else:
		return Vector3.ZERO  # Or any default value you prefer


