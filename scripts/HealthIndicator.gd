extends NodeAnimated

onready var meds_progress: TextureProgress = $TextureProgress/MedsProgress

func _on_Health_Button_pressed() -> void:
	Global.MedsApply.open()

func setMedProgress(time,totalTime):
	totalTime = max(totalTime,1)
	meds_progress.max_value = totalTime+1
	meds_progress.animateValue(float(time))
