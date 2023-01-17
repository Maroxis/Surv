extends Control

func open():
	self.rect_position.y = self.rect_size.y
	show()
	var tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)
	tween.tween_property(self, "rect_position:y", 0.0, 0.8)

func close():
	var tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)
	tween.tween_property(self, "rect_position:y", self.rect_size.y, 0.8)
	tween.tween_callback(self, "hide")

func _on_Return_Button_pressed() -> void:
	close()
