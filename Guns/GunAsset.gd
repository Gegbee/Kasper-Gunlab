extends Node2D

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

export (GUNS) var gun_name

func shoot():
	$AnimationPlayer.play("Firing")
	$AudioStreamPlayer.play()
	$AudioStreamPlayer2.play()

func start_reload():
	$AudioStreamPlayer3.play()
	$AudioStreamPlayer4.play()
func finish_reload():
	$AudioStreamPlayer5.play()
