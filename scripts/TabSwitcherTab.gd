extends Control

onready var icon: TextureRect = $Icon

signal tabClicked
var tab

func init(id,tex):
	tab = id
	icon.texture = load("res://sprites/UI/tabs/"+tex+".png")

func _on_TextureButton_pressed() -> void:
	emit_signal("tabClicked",tab)
