extends Control

onready var icon: TextureRect = $Icon

func changeText(tex) -> void:
	icon.texture = load("res://sprites/Icons/32x32px/"+tex.to_lower()+".png")
