extends Control

# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
onready var vx = get_viewport().size.x
onready var cx = rect_position.x

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _on_Start_pressed() -> void:
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://nodes/Game.tscn")

func _on_Quit_pressed() -> void:
	get_tree().quit()
