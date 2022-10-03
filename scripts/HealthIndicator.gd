extends NodeAnimated

onready var meds_progress: TextureProgress = $TextureProgress/MedsProgress

func _on_Health_Button_pressed() -> void:
	Global.MedsApply.open()

func setMedMaxTime(time):
	time = max(time,1)
	meds_progress.max_value = time

func setMedProgress(time):
	meds_progress.animateValue(float(time))
