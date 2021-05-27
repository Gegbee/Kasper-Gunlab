extends CanvasLayer

onready var reload = $VBoxContainer/Reload

func _ready():
	reload.hide()

func add_gun(ammo_capacity : int):
	reload.max_value = ammo_capacity
	reload.value = 0
	reload.show()
	
func remove_gun():
	$Tween.stop_all()
	reload.hide()
	
func update_ammo(amt : int):
	reload.value = amt
	
func reload_ammo(reload_time : float):
	$Tween.interpolate_property(reload, "value", reload.min_value, reload.max_value, reload_time, Tween.TRANS_LINEAR)
	$Tween.start()
