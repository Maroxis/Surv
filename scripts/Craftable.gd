extends Control

class_name Craftable

func fade():
	var tween = create_tween().set_ease(Tween.EASE_IN_OUT)
	tween.connect("finished", self, "hide")
	tween.tween_property(self, "modulate", Color(0,0,0,0), 0.4)
	
func hide():
	self.visible = false
	
func craftBtAnim(_button,_btpos):
#	var tween = create_tween().set_ease(Tween.EASE_IN_OUT)
	pass
