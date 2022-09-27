extends Node
class_name NodeAnimated

var curPos = self.rect_position
var tweenInProgress = 0

func shake(distance = 10, del = 0.1, sideways = false):
	if tweenInProgress == 0:
		curPos = self.rect_position
	tweenInProgress += 1
	
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
	tween.connect("finished",self,"tweenFinished")
	
func tweenFinished():
	tweenInProgress -= 1

func shakeSide():
	shake(5,0.05,true)

func fadeIn(time):
#	self.visible = true
	var tween = create_tween().set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self, "modulate:a", 1.0, time)
	
func fadeOut(time):
	var tween = create_tween().set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self, "modulate:a", 0.0, time)
#	tween.tween_property(self, "visible", false, time)
