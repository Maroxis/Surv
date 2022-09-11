extends Control

signal selected
var module
onready var selected = false
onready var icon: TextureRect = $Icon
onready var bg: TextureRect = $BG
onready var button: Button = $Button
onready var tool_icon: TextureRect = $ToolReq/ToolIcon
onready var mod_icon: TextureRect = $ModReq/ModIcon
onready var mod_req: ColorRect = $ModReq
onready var tool_req: ColorRect = $ToolReq

func init(mod,disabled,tl,md):
	module = mod
	icon.texture = load("res://sprites/Icons/64x64px/"+mod.to_lower()+".png")
	if disabled:
		disable()
	reqTool(tl)
	reqMod(md)

func reqTool(tl):
	if(tl):
		tool_icon.texture = load("res://sprites/Icons/32x32px/"+tl.to_lower()+".png")
		tool_req.show()
	else:
		tool_req.hide()
		
func reqMod(md):
	if(md):
		mod_icon.texture = load("res://sprites/Icons/32x32px/"+md.to_lower()+".png")
		mod_req.show()
	else:
		mod_req.hide()



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
