extends Node
class_name NodeAnimated

onready var curPos = self.rect_position

func shake(distance = 10, del = 0.1, sideways = false):
	var tween = create_tween().set_ease(Tween.EASE_OUT)
	if(sideways):
		tween.tween_property(self, "rect_position", curPos - Vector2(distance,0), del)
		for i in 3:
			tween.tween_property(self, "rect_position", curPos + Vector2(distance,0), del*2)
			tween.tween_property(self, "rect_position", curPos - Vector2(distance,0), del*2)
		tween.tween_property(self, "rect_position", curPos, del)
	else:
		tween.tween_property(self, "rect_position", curPos + Vector2(0,distance), del)
		tween.tween_property(self, "rect_position", curPos - Vector2(0,distance), del*2)
		tween.tween_property(self, "rect_position", curPos, del)
