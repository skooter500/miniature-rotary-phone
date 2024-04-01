class_name Utils extends Node

# http://www.elitehomepage.org/playguide.htm#A22

func find_node_from(root: Node, name:String) -> Node:
	# Check if the current node is the one we're looking for
	if root.name == name:
		return root
	
	# If the current node is not the one we're looking for, recursively search its children
	for child in root.get_children():
		var result = find_child(child.name)
		if result != null:
			return result
	
	# If the node is not found in the current node or its children, return null
	return null

static func random_point_in_unit_sphere() -> Vector3:
	var theta = randf_range(0, 2 * PI)
	var phi = randf_range(0, PI)
	var r = pow(randf_range(0, 1), 1.0/3.0)  # Cube root for uniform distribution

	var x = r * sin(phi) * cos(theta)
	var y = r * sin(phi) * sin(theta)
	var z = r * cos(phi)
	return Vector3(x, y, z)

# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
