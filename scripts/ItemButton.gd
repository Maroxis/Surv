extends NodeAnimated

onready var bg: NinePatchRect = $BG

func disable():
	bg.modulate = Color(0.4,0.4,0.4)
	self.disabled = true

func enable():
	bg.modulate = Color(1,1,1)
	self.disabled = false
