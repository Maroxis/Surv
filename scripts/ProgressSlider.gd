extends ProgressBar
class_name ProgressSlider
onready var h_slider: HSlider = $HSlider
onready var db_indicator: Label = $DbIndicator

func _ready() -> void:
	emit_signal("value_changed",value)
	h_slider.min_value = min_value
	h_slider.max_value = max_value
	h_slider.step = step
	h_slider.page = page
	
func set_val(val):
	h_slider.value = val

func get_db():
	return linear2db(h_slider.value)

func _on_HSlider_value_changed(value: float) -> void:
	self.value = value
	db_indicator.text =( "%.2f" % linear2db(value) ) + "db"
