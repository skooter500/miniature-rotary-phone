extends Timer

class_name Stamina

@export_range(10, 1000)
var max: float = 100
@export
var regen: bool = true: 
	set(value):
		update_wait_time(value)
		regen = value

@export_category("Regen")
@export_range(1,100)
var regen_value: float = 1
@export_range(0.1, 100)
var regen_time: float = 0.1

@export_category("Cost")
@export_range(1,100)
var cost_value: float = 1
@export_range(0.1, 100)
var cost_time: float = 0.1

var stamina: float = 0

signal stamina_depleted
signal stamina_replenished

func _ready() -> void:
	update_wait_time(regen)
	timeout.connect(_on_timeout)


func _on_timeout():
	update_stamina()
	check_stamina()

func update_stamina():
	if regen:
		stamina += regen_value
	else:
		stamina -= cost_value
	stamina = clamp(stamina, 0, max)
	
func check_stamina():
	if stamina == max:
		stamina_replenished.emit()
	elif stamina == 0:
		stamina_depleted.emit()

func update_wait_time(value):
	if value:
		wait_time = regen_time
	else:
		wait_time = cost_time
