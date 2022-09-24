extends CanvasLayer

#onready var vx = get_viewport().size.x
#onready var cx = rect_position.x
var game = preload("res://nodes/Game.tscn")

func _on_Start_pressed() -> void:
# warning-ignore:return_value_discarded
	get_tree().change_scene_to(game)

func _on_Quit_pressed() -> void:
	get_tree().quit()
