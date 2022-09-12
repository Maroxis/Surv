extends ProgressBar
class_name ProgressSlider
onready var h_slider: HSlider = $HSlider

func _ready() -> void:
	emit_signal("value_changed",value)
	h_slider.min_value = min_value
	h_slider.max_value = max_value
	h_slider.step = step
	h_slider.page = page

func _on_HSlider_value_changed(value: float) -> void:
	self.value = value
