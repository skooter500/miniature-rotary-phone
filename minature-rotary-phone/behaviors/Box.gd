extends RigidBody3D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func _process(delta):
	pass
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_RigidBody_body_entered(body):
	if (body.name == "bullet"):
		print("Collided with: "  + str(body))
		body.queue_free()
		# body.get_parent().remove_child(body)
