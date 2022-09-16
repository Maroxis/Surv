extends Control

#export var look_at = Vector2(0,0)
export var ySkew = 0.0
onready var bg = $BG
onready var icon = $Icon

func _ready():
#	look_at *= -1
	icon.material = icon.material.duplicate()
	bg.material = bg.material.duplicate()
#	icon.material.set_shader_param("width", self.rect_size.x)
#	bg.material.set_shader_param("width", self.rect_size.x)
#	icon.material.set_shader_param("height", self.rect_size.y)
#	bg.material.set_shader_param("height",self.rect_size.y)
#	icon.material.set_shader_param("look_position", look_at)
#	bg.material.set_shader_param("look_position", look_at)
	icon.material.set_shader_param("skew_y", ySkew)
	bg.material.set_shader_param("skew_y", ySkew)
