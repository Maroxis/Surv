extends HSlider
class_name ProgressSlider
onready var db_indicator: Label = $DbIndicator
onready var texture_progress: TextureProgress = $TextureProgress

func _ready() -> void:
	emit_signal("value_changed",value)

func set_val(val):
	self.value = val

func set_mute(muted):
	if muted:
		texture_progress.tint_progress = Color("ff0000")
	else:
		texture_progress.tint_progress = Color("08ff00")

func get_db():
	return linear2db(value)

func _on_ProgressSlider_value_changed(value: float) -> void:
	db_indicator.text =( "%.2f" % linear2db(value) ) + "db"
	texture_progress.value = value
