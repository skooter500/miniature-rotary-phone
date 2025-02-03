# Node structure for Buck Rogers Starfighter
@tool
extends Node3D

func _ready():
	setup_starfighter()

func setup_starfighter():
	# Create main node
	var starfighter = CSGCombiner3D.new()
	starfighter.name = "Starfighter"
	add_child(starfighter)
	
	# Create base materials
	var white_material = StandardMaterial3D.new()
	white_material.albedo_color = Color(0.9, 0.9, 0.9)
	white_material.metallic = 0.7
	white_material.roughness = 0.2
	
	var accent_material = StandardMaterial3D.new()
	accent_material.albedo_color = Color(0.8, 0.2, 0.1)
	accent_material.metallic = 0.5
	accent_material.roughness = 0.3
	
	# Main fuselage
	var fuselage = CSGCylinder3D.new()
	fuselage.name = "Fuselage"
	fuselage.radius = 1.0
	fuselage.height = 8.0
	fuselage.sides = 16
	fuselage.material = white_material
	fuselage.rotation_degrees.x = 90
	starfighter.add_child(fuselage)
	
	# Nose cone
	var nose = CSGCylinder3D.new()
	nose.name = "NoseCone"
	nose.radius = 1.0
	nose.height = 3.0
	nose.cone = true
	nose.material = white_material
	nose.position = Vector3(0, 0, -5.5)
	nose.rotation_degrees.x = 90
	starfighter.add_child(nose)
	
	# Wings (using CSGPolygon3D)
	var wing = CSGPolygon3D.new()
	wing.name = "Wing"
	wing.polygon = PackedVector2Array([
		Vector2(0, 0),
		Vector2(4, 1),
		Vector2(4.5, 2),
		Vector2(4, 3),
		Vector2(0, 4)
	])
	wing.depth = 0.2
	wing.material = white_material
	wing.position = Vector3(0, 0, 0)
	starfighter.add_child(wing)
	
	# Mirror wing
	var wing2 = wing.duplicate()
	wing2.scale.x = -1
	starfighter.add_child(wing2)
	
	# Engine housing (left)
	var engine_left = CSGCylinder3D.new()
	engine_left.name = "EngineLeft"
	engine_left.radius = 0.5
	engine_left.height = 4.0
	engine_left.material = white_material
	engine_left.position = Vector3(-1.5, 0, 2)
	engine_left.rotation_degrees.x = 90
	starfighter.add_child(engine_left)
	
	# Engine housing (right)
	var engine_right = engine_left.duplicate()
	engine_right.name = "EngineRight"
	engine_right.position.x *= -1
	starfighter.add_child(engine_right)
	
	# Engine nozzles
	var nozzle_left = CSGCylinder3D.new()
	nozzle_left.name = "NozzleLeft"
	nozzle_left.radius = 0.3
	nozzle_left.height = 0.5
	nozzle_left.material = accent_material
	nozzle_left.position = Vector3(-1.5, 0, 4)
	nozzle_left.rotation_degrees.x = 90
	starfighter.add_child(nozzle_left)
	
	var nozzle_right = nozzle_left.duplicate()
	nozzle_right.name = "NozzleRight"
	nozzle_right.position.x *= -1
	starfighter.add_child(nozzle_right)
	
	# Cockpit (using CSGPolygon3D for the canopy)
	var cockpit = CSGPolygon3D.new()
	cockpit.name = "Cockpit"
	cockpit.polygon = PackedVector2Array([
		Vector2(0, 0),
		Vector2(0.8, 0),
		Vector2(0.6, 0.6),
		Vector2(0, 0.8)
	])
	cockpit.depth = 2.0
	var cockpit_material = StandardMaterial3D.new()
	cockpit_material.albedo_color = Color(0.2, 0.4, 0.8, 0.5)
	cockpit_material.metallic = 0.9
	cockpit_material.roughness = 0.1
	cockpit_material.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
	cockpit.material = cockpit_material
	cockpit.position = Vector3(0, 0.8, -2)
	starfighter.add_child(cockpit)
	
	# Add boolean operations for details
	add_panel_lines(starfighter, white_material)

func add_panel_lines(starfighter: CSGCombiner3D, material: Material):
	# Add panel lines using CSG subtraction
	var panel_line = CSGBox3D.new()
	panel_line.name = "PanelLine"
	panel_line.size = Vector3(2.2, 0.05, 0.05)
	panel_line.material = material
	panel_line.operation = CSGShape3D.OPERATION_SUBTRACTION
	panel_line.position = Vector3(0, 0, -1)
	starfighter.add_child(panel_line)
	
	# Duplicate panel lines for other sections
	for i in range(3):
		var new_line = panel_line.duplicate()
		new_line.position.z += i * 2
		starfighter.add_child(new_line)
