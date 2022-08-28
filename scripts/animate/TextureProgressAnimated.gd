extends NodeAnimated

var flashTween

func animateValue(val):
	var tween = create_tween()
	tween.tween_property(self, "value", val, 0.3)
	
func flashBar(start):
	print(start)
	print(flashTween == null)
	print(start and flashTween == null)
	if(start and flashTween == null):
		flashTween = create_tween()
		flashTween.set_loops()
		flashTween.tween_property(self, "tint_progress:a", 0.0, 0.7).set_delay(3)
		flashTween.tween_property(self, "tint_progress:a", 1.0, 0.7)
	if(flashTween and not start):
		flashTween.kill()
		self.tint_progress.a = 1.0
