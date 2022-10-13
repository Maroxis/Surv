extends NodeAnimated

var flashTween

func animateValue(val):
	var tween = create_tween()
	tween.tween_property(self, "value", val, 0.3)
	
func flashBar(start):
	if(start):
		if flashTween:
			flashTween.kill()
		self.tint_progress.a = 1.0
		flashTween = create_tween()
		flashTween.set_loops()
		flashTween.tween_property(self, "tint_progress:a", 0.0, 0.7).set_delay(1.2)
		flashTween.tween_property(self, "tint_progress:a", 1.0, 0.7)
	if(flashTween and not start):
		flashTween.kill()
		self.tint_progress.a = 1.0
