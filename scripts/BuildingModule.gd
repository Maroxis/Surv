extends Control

signal selected
var module
onready var selected = false
onready var icon: TextureRect = $Icon
onready var bg: TextureRect = $BG
onready var button: Button = $Button

func init(mod,disabled):
	module = mod
	icon.texture = load("res://sprites/Icons/64x64px/"+mod.to_lower()+".png")
	if disabled:
		disable()

func disable():
	button.disabled = true
	bg.self_modulate.a = 0.4
	
func select():
	selected = true
	bg.self_modulate.r8 = 158
	bg.self_modulate.g8 = 77
	bg.self_modulate.b8 = 0
func deselect():
	selected = false
	bg.self_modulate.r8 = 255
	bg.self_modulate.g8 = 124
	bg.self_modulate.b8 = 0

func _on_Button_pressed() -> void:
	emit_signal("selected",module,self)
