extends Node2D

export (bool) var automatic = true
export (float) var fire_rate = 0.5
export (int) var magazine_size = 30
export (float) var reload_time = 1
export (int) var damage = 15
export (int) var bullet_speed = 40
export (float) var min_accuracy = 4
export (float) var accuracy_decrease = 1
export (float) var accuracy_increase = 0.1
export (float) var max_accuracy = 10
export (float) var accuracy_increase_delay = 0.2
export (int, 1, 10) var bullet_per_shot = 1

onready var asset = $Asset.get_child(0)
onready var gun_name = asset.gun_name
var bullet = Preloads.BULLET

var can_fire := true
var current_magazine : int
var current_accuracy : float
var current_downtime : float = 0

onready var shot_timer := $ShotTimer
onready var reload_timer := $ReloadTimer
onready var player_ui = get_tree().get_nodes_in_group("PlayerUI")[0]

func _ready():
	randomize()
	current_magazine = 0
	current_accuracy = min_accuracy
	player_ui.add_gun(magazine_size)
	reload()
	
func _process(delta):
	var mouse_pos = get_global_mouse_position() - global_position
	rotation_degrees = int(rad2deg(atan2(mouse_pos.y, mouse_pos.x)))
	asset.scale.x = clamp(abs(cos(rotation)), 0.7, 1)
	if sin(rotation) < 0:
		get_parent().show_behind_parent = true
	else:
		get_parent().show_behind_parent = false
	if cos(rotation) < 0:
		asset.scale.y = clamp(abs(cos(rotation)), 0.6, 1) * -1
	else:
		asset.scale.y = clamp(abs(cos(rotation)), 0.6, 1) * 1
	position.x = cos(rotation) * 5
	
	if Input.is_action_just_pressed("reload") and reload_timer.is_stopped():
		reload()
		
	if automatic:
		if Input.is_action_pressed("shoot") and can_fire and current_magazine > 0:
			fire()
	else:
		if Input.is_action_just_pressed("shoot") and can_fire and current_magazine > 0:
			fire()
		
	if Input.is_action_just_pressed("drop_take"):
		remove()
		
	current_downtime += delta
	if current_downtime >= accuracy_increase_delay and current_accuracy != min_accuracy:
		current_accuracy = current_accuracy + -accuracy_increase * current_downtime
	current_accuracy = clamp(current_accuracy, min_accuracy, max_accuracy)

func remove():
	player_ui.remove_gun()
	var dropped_gun_instance = Preloads.DROPPED_GUN.instance()
	dropped_gun_instance.gun_name = gun_name
	dropped_gun_instance.global_position = global_position
	var root_y_sort = get_node("/root").get_child(0)
	root_y_sort.add_child(dropped_gun_instance)
	dropped_gun_instance.apply_central_impulse((get_global_mouse_position() - global_position))
	get_parent().queue_free()

func reload():
	can_fire = false
	player_ui.reload_ammo(reload_time)
	asset.start_reload()
	reload_timer.start(reload_time)
	
func fire():
	current_downtime = 0
	can_fire = false
	shot_timer.start(fire_rate)
	update_magazine(current_magazine - 1)
	asset.shoot()
	for shot in bullet_per_shot:
		var bullet_instance = bullet.instance()
		bullet_instance.damage = damage
		bullet_instance.speed = bullet_speed * 1000
		var absolute_rotation = rotation + (rand_range(-current_accuracy, current_accuracy) / 100 * PI)
		var bullet_direction = Vector2(cos(absolute_rotation),sin(absolute_rotation))
		bullet_instance.direction = bullet_direction
		bullet_instance.position = $Muzzle.global_position
		bullet_instance.initial_position = bullet_instance.position
		get_node("/root").add_child(bullet_instance)
	current_accuracy += accuracy_decrease
	
func _on_ReloadTimer_timeout():
	update_magazine(magazine_size)
	asset.finish_reload()
	can_fire = true

func _on_ShotTimer_timeout():
	if reload_timer.is_stopped():
		can_fire = true

func update_magazine(amt : int):
	current_magazine = amt
	player_ui.update_ammo(current_magazine)
