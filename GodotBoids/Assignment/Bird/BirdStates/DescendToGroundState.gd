extends State

class_name DescendToGroundState


func _enter():
	change_behaviour("Sepratation", false)
	change_behaviour("Alignment", false)
	change_behaviour("Cohesion", false)
	change_behaviour("Harmonic", false)
	change_behaviour("NoiseWander", false)
	change_behaviour("Arrive", true)
	pass

func _think():
	pass
	
