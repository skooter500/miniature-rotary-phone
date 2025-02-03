@tool
extends Node3D

func _ready():
    setup_starfighter()

func setup_starfighter():
    var starfighter = CSGCombiner3D.new()
    starfighter.name = "Starfighter"
    add_child(starfighter)
    
    # Materials
    var white_material = StandardMaterial3D.new()
    white_material.albedo_color = Color(0.9, 0.9, 0.9)
    white_material.metallic = 0.7
    white_material.roughness = 0.2
    
    var accent_material = StandardMaterial3D.new()
    accent_material.albedo_color = Color(0.8, 0.2, 0.1)
    accent_material.metallic = 0.5
    accent_material.roughness = 0.3
    
    # Main fuselage - using CSGPolygon for better shape control
    var fuselage = CSGPolygon3D.new()
    fuselage.name = "Fuselage"
    fuselage.polygon = PackedVector2Array([
        Vector2(-1.0, -0.5),
        Vector2(1.0, -0.5),
        Vector2(0.8, 0.5),
        Vector2(-0.8, 0.5)
    ])
    fuselage.depth = 8.0
    fuselage.material = white_material
    fuselage.rotation_degrees.x = 90
    starfighter.add_child(fuselage)
    
    # More complex nose cone using multiple CSG operations
    var nose_base = CSGPolygon3D.new()
    nose_base.name = "NoseBase"
    nose_base.polygon = PackedVector2Array([
        Vector2(-0.8, 0),
        Vector2(0.8, 0),
        Vector2(0.4, 2),
        Vector2(-0.4, 2)
    ])
    nose_base.depth = 0.1
    nose_base.material = white_material
    nose_base.position = Vector3(0, 0, -5.5)
    nose_base.rotation_degrees.x = 90
    starfighter.add_child(nose_base)
    
    # Wings with better angle and profile
    var wing = CSGPolygon3D.new()
    wing.name = "Wing"
    wing.polygon = PackedVector2Array([
        Vector2(0, -0.2),
        Vector2(4, -0.1),
        Vector2(3.8, 0),
        Vector2(3.5, 0.1),
        Vector2(0, 0.2)
    ])
    wing.depth = 3.0
    wing.material = white_material
    wing.position = Vector3(0.8, 0, -1)
    wing.rotation_degrees = Vector3(0, -15, 0)  # Sweep back angle
    starfighter.add_child(wing)
    
    # Mirror wing
    var wing2 = wing.duplicate()
    wing2.position.x = -0.8
    wing2.rotation_degrees.y = 15  # Opposite sweep
    starfighter.add_child(wing2)
    
    # Integrated engine housings
    var engine_left = CSGCylinder3D.new()
    engine_left.name = "EngineLeft"
    engine_left.radius = 0.4
    engine_left.height = 6.0
    engine_left.material = white_material
    engine_left.position = Vector3(-0.8, 0, 1)
    engine_left.rotation_degrees.x = 90
    starfighter.add_child(engine_left)
    
    var engine_right = engine_left.duplicate()
    engine_right.position.x = 0.8
    starfighter.add_child(engine_right)
    
    # Engine nozzles with better integration
    var nozzle_left = CSGCylinder3D.new()
    nozzle_left.name = "NozzleLeft"
    nozzle_left.radius = 0.3
    nozzle_left.height = 0.5
    nozzle_left.material = accent_material
    nozzle_left.position = Vector3(-0.8, 0, 4)
    nozzle_left.rotation_degrees.x = 90
    starfighter.add_child(nozzle_left)
    
    var nozzle_right = nozzle_left.duplicate()
    nozzle_right.position.x = 0.8
    starfighter.add_child(nozzle_right)
    
    # Improved cockpit integration
    var cockpit = CSGPolygon3D.new()
    cockpit.name = "Cockpit"
    cockpit.polygon = PackedVector2Array([
        Vector2(-0.6, 0),
        Vector2(0.6, 0),
        Vector2(0.4, 0.4),
        Vector2(-0.4, 0.4)
    ])
    cockpit.depth = 1.5
    var cockpit_material = StandardMaterial3D.new()
    cockpit_material.albedo_color = Color(0.2, 0.4, 0.8, 0.5)
    cockpit_material.metallic = 0.9
    cockpit_material.roughness = 0.1
    cockpit_material.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
    cockpit.material = cockpit_material
    cockpit.position = Vector3(0, 0.5, -2)
    starfighter.add_child(cockpit)
    
    # Detail elements
    add_detail_elements(starfighter, white_material)

func add_detail_elements(starfighter: CSGCombiner3D, material: Material):
    # Panel lines and surface details
    var panel_line = CSGBox3D.new()
    panel_line.name = "PanelLine"
    panel_line.size = Vector3(2.0, 0.02, 0.02)
    panel_line.material = material
    panel_line.operation = CSGShape3D.OPERATION_SUBTRACTION
    panel_line.position = Vector3(0, 0, -1)
    starfighter.add_child(panel_line)
    
    # Add more panel lines along the length
    for i in range(4):
        var new_line = panel_line.duplicate()
        new_line.position.z += i * 1.5
        starfighter.add_child(new_line)