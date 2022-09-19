extends Control
class_name MissionBasic

onready var pos = self.rect_position

func close():
	var tween = create_tween().set_ease(Tween.EASE_IN)
	tween.tween_property(self, "rect_position:y", pos.y + rect_size.y, 0.4)
	tween.tween_callback(self, "hide")

func travel():
	self.rect_position.y = pos.y + self.rect_size.y
	show()
	var tween = create_tween().set_ease(Tween.EASE_IN)
	tween.tween_property(self, "rect_position:y", pos.y, 0.4)
