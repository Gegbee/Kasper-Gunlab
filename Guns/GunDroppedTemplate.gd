extends RigidBody2D

var player = null
var gun_name

func _ready():
	$Asset.add_child(Preloads.ASSET_GUN_LOADS[gun_name].instance())
	
func _process(_delta):
	if player != null and player.possible_guns[0] == self and Input.is_action_just_pressed("drop_take"):
		player.add_child(Preloads.HELD_GUN_LOADS[gun_name].instance())
		queue_free()
	$Asset.scale.x = clamp(cos(rotation), 0.7, 1)

func _on_Area2D_body_entered(body):
	if body.is_in_group("Player"):
		player = body
		player.possible_guns.append(self)
		
func _on_Area2D_body_exited(body):
	if body.is_in_group("Player"):
		player.possible_guns.erase(self)
		player = null
