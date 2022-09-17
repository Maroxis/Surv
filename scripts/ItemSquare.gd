extends Control

#export var look_at = Vector2(0,0)
onready var bg = $BG
onready var icon = $Icon

var item_name

func _ready():
#	look_at *= -1
	icon.material = icon.material.duplicate()
	bg.material = bg.material.duplicate()
	
func setSkew(skew):
	icon.material.set_shader_param("skew_y", skew)
	bg.material.set_shader_param("skew_y", skew)

func init(nm):
	item_name = nm
	icon.texture = load("res://sprites/Icons/64x64px/"+nm.to_lower()+".png")
