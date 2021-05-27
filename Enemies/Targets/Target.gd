extends StaticBody2D


var health : int = 100
var hit_force : float = 0.0

func _ready():
	set_health(health)

func _process(_delta):
	hit_force = lerp(hit_force, 0.0, 0.2)
	$Sprite.rotation = lerp($Sprite.rotation, hit_force / 40, 0.2)
	
func damage(amt : int, hit_position : Vector2 = Vector2()):
	hit_force += amt * (hit_position.x - global_position.x) * -1
	$HitParticles.global_position = hit_position
	$HitParticles.restart()
	$AudioStreamPlayer.pitch_scale = rand_range(0.8, 1.2)
	$AudioStreamPlayer.play()
	if $HealthTimer.is_stopped():
		set_health(health - amt)
		if health == 0:
			$HealthTimer.start(3.0)

func set_health(amt : int):
	health = amt
	health = clamp(health, 0, 100)
	$Health.value = health


func _on_HealthTimer_timeout():
	set_health(100)
