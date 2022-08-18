extends Node
class_name NodeAnimated

onready var curPos = self.rect_position

func shake(distance = 10):
	var tween = create_tween().set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "rect_position", curPos + Vector2(0,distance), 0.1)
	tween.tween_property(self, "rect_position", curPos - Vector2(0,distance), 0.2)
	tween.tween_property(self, "rect_position", curPos, 0.1)
