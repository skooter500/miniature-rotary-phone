extends HSlider
var bus_index : int

# Called when the node enters the scene tree for the first time.
func _ready():
	bus_index = AudioServer.get_bus_index("SFX")
	value_changed.connect(_on_value_changed)

func _on_value_changed(value):
	AudioServer.set_bus_volume_db(
		bus_index,
		linear_to_db(value)
	)
