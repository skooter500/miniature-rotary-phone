extends State

class_name LandState

func _enter():
	disable_all_behaviours()
	change_behaviour("Avoidance", true)
	change_behaviour("Arrive", true)
	var missed_approach_timer = boid.find_child("Timer")
	missed_approach_timer.timeout.connect(_on_missed_approach)
	missed_approach_timer.start(15)
	
func _think():
	#var arrive: Arrive = boid.get_node("Arrive")
	#if arrive and boid.position.distance_to(arrive.target.position) <= 5:
		#change_behaviour("Arrive", false)	
	for i in boid.get_slide_collision_count():
		var collision = boid.get_slide_collision(i)
		if collision.get_collider().name == "Ground":
			change_behaviour("Avoidance", false) 
			change_behaviour("Arrive", false)	
			# Come to complete stop
			boid.pause = true
			var body = boid.get_node("MeshInstance3D")
			body.state = "Walking"
			var wings = boid.body.find_children("Wing?")
			for wing in wings:
				wing.play_slowdown = true
			var tween = get_tree().create_tween()
			tween.parallel().tween_property(boid, "rotation_degrees:x", 0, body.druation)
			tween.parallel().tween_property(boid, "global_position:y", boid.ground.position.y+(boid.height/2), body.druation)
			tween.play()
			var new_state = GroundState.new()
			new_state.name = "GroundState"
			state_machine.change_state(new_state)

func _on_missed_approach():
	var new_state = TakeOffState.new()
	new_state.name = "TakeOffState"
	state_machine.change_state(new_state)
