extends Node
class_name NodeAnimated

onready var curPos = self.rect_position

func shake(distance = 10, del = 0.1, sideways = false):
	var tween = create_tween().set_ease(Tween.EASE_OUT)
	if(sideways):
		tween.tween_property(self, "rect_position:x", curPos.x - distance, del)
		for i in 3:
			tween.tween_property(self, "rect_position:x", curPos.x + distance, del*2)
			tween.tween_property(self, "rect_position:x", curPos.x - distance, del*2)
		tween.tween_property(self, "rect_position:x", curPos.x, del)
	else:
		tween.tween_property(self, "rect_position:y", curPos.y + distance, del)
		tween.tween_property(self, "rect_position:y", curPos.y - distance, del*2)
		tween.tween_property(self, "rect_position:y", curPos.y, del)
		
func fadeIn(time):
	var tween = create_tween().set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self, "modulate:a", 1.0, time)
	
func fadeOut(time):
	var tween = create_tween().set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self, "modulate:a", 0.0, time)
