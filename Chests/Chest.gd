extends StaticBody2D

enum GUNS {
	KAR,
	KMG,
	KMULTI,
	KONE,
	KPSTL,
	KREVO,
	KSHORT,
	KSMG
}
var rng = RandomNumberGenerator.new()

var player = null
var opened := false
export (bool) var random = false
export (GUNS) var gun_name

func _ready():
	rng.randomize()

func _process(_delta):
	if player != null and opened == false and Input.is_action_just_pressed("open"):
		var dropped_gun_instance = Preloads.DROPPED_GUN.instance()
		if !random:
			dropped_gun_instance.gun_name = gun_name
		else:
			dropped_gun_instance.gun_name = rng.randi_range(0, GUNS.size() - 1)
		dropped_gun_instance.global_position = global_position
		var root_y_sort = get_node("/root").get_child(0)
		root_y_sort.add_child(dropped_gun_instance)
		dropped_gun_instance.apply_central_impulse(Vector2(0, 1) * 100)
		opened = true
		
func _on_Area2D_body_entered(body):
	if body.is_in_group("Player"):
		player = body


func _on_Area2D_body_exited(body):
	if body.is_in_group("Player"):
		player = null
