extends NodeAnimated

func animateValue(val):
	var tween = create_tween()
	tween.tween_property(self, "value", val, 0.3)
