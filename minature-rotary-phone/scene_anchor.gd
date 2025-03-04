extends StaticBody3D

@onready var label: Label3D = $Label3D

func setup_scene(entity: OpenXRFbSpatialEntity) -> void:
	var semantic_labels: PackedStringArray = entity.get_semantic_labels()

	label.text = semantic_labels[0]

	var collision_shape = entity.create_collision_shape()
	if collision_shape:
		add_child(collision_shape)

	var mesh_instance = entity.create_mesh_instance()
	if mesh_instance:
		add_child(mesh_instance)
