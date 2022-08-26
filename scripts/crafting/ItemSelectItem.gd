extends Control

onready var icon: TextureRect = $Icon

func changeText(tex) -> void:
	icon.texture = load("res://sprites/Icons/resources/"+tex.to_lower()+".png")
