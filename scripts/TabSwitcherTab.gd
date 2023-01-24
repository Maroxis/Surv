extends Control

onready var icon: TextureRect = $Icon
onready var texture_button: TextureButton = $TextureButton

signal tabClicked
var tab

func _ready() -> void:
	deselect()

func init():
	deselect()

func changeIcon(text: String,size: int = 32):
	icon.texture = load("res://sprites/Icons/"+str(size)+"x"+str(size)+"px/"+text.to_lower()+".png")

func select():
	texture_button.modulate = Color(0,0.8,0,1)
func deselect():
	texture_button.modulate = Color(1,0.5,0,1)
func _on_TextureButton_pressed() -> void:
	emit_signal("tabClicked",tab)
	Global.Sound.play(Sound.UI_DEFAULT_SHORT, "SFX")
