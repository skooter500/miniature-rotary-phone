extends Node3D

@onready var flower = get_node("Nature/Clump4/Clump4_GRADIENT_0").global_transform
@onready var flower2 = get_node("Nature/FlowerY2").global_transform
@onready var world_environment : WorldEnvironment = $WorldEnvironment 
@onready var light : DirectionalLight3D = $DirectionalLight3D
 
# Called when the node enters the scene tree for the first time.
func _ready():
	Parameters.connect("SET_DAY_NIGHT", _change_day_night)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# tell butterflies where the flowers are
	Parameters.FLOWER_POSITION.emit(flower)
	Parameters.FLOWER_POSITION2.emit(flower2)

func _change_day_night(value):
	world_environment.environment.background_mode = Environment.BG_SKY
	if value:
		var panorama_sky_material_day = PanoramaSkyMaterial.new()
		panorama_sky_material_day = load("res://map/map_assets/night.tres")
		world_environment.environment.sky.sky_material = panorama_sky_material_day
		light.light_color = Color(0,0,.8)
		light.light_energy = 2.5
	else:
		var panorama_sky_material_night = PanoramaSkyMaterial.new()
		panorama_sky_material_night = load("res://map/map_assets/day.tres")
		world_environment.environment.sky.sky_material = panorama_sky_material_night
		light.light_color = Color(1,1,1)
		light.light_energy = 2
