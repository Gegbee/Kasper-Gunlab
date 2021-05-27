extends KinematicBody2D

const SPEED := 5000
var possible_guns := []
var health := 100
var timing := false

func _physics_process(delta):
	var velocity = Vector2()
	var vel_x = Input.get_action_strength("right") - Input.get_action_strength("left")
	var vel_y = Input.get_action_strength("down") - Input.get_action_strength("up")
	
	if vel_x > 0:
		$AnimationPlayer.play("Right")
	elif vel_x < 0:
		$AnimationPlayer.play("Left")
	elif vel_y > 0:
		$AnimationPlayer.play("Down")
	elif vel_y < 0:
		$AnimationPlayer.play("Up")
	velocity = Vector2(vel_x, vel_y)
	if velocity.length() == 0:
		$AnimationPlayer.play("Idle")
	else:
		if $Timer.is_stopped():
			play_footstep()
			$Timer.start(0.2)
	var _movement = move_and_slide(velocity.normalized() * SPEED * delta)

func play_footstep():
	$AudioStreamPlayer.pitch_scale = rand_range(0.8, 1.2)
	$AudioStreamPlayer.play()

