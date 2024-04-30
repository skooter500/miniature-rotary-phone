extends State

class_name LandState

func _enter():
	change_behaviour("Arrive", false)
	change_behaviour("Constrain", false)
	#change_behaviour("Avoidance", false)
	
func _think():
	for i in boid.get_slide_collision_count():
		var collision = boid.get_slide_collision(i)
		if collision.get_collider().name == "Ground":
			change_behaviour("Avoidance", false) 
			# Come to complete stop
			boid.pause = true
			var body = boid.get_node("MeshInstance3D")
			body.state = "Walking"
			var tween = get_tree().create_tween()
			tween.parallel().tween_property(boid, "rotation_degrees:x", 0, body.druation)
			tween.parallel().tween_property(boid, "global_position:y", boid.ground.position.y+(boid.height/2), body.druation)
			tween.play()
		print("I collided with ", collision.get_collider().name)
	#if boid.rotation_degrees.x < 0:
