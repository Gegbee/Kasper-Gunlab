tool
extends Sprite

func _ready():
	set_material(get_material().duplicate())
	material.set_shader_param("position", get_parent().global_position)
