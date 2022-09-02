extends Node

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

func loadTex(item):
	var tex = self.name.to_lower()
	item.texture = load("res://sprites/Icons/128x128px/"+tex+".png")
	item.modulate = Color(0.0,0.0,0.0,1.0)
	
