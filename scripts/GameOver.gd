extends Control

class_name GameOver

onready var time_lived_label: Label = $VBoxContainer/HBoxContainer/NinePatchRect/TimeLivedLabel
onready var record_lived_label: Label = $VBoxContainer/HBoxContainer/NinePatchRect2/RecordLivedLabel
onready var death_reason_label: Label = $VBoxContainer/DeathReasonLabel
enum reasons {Water, Food, Energy, Sick, Combat}

var recordAdded = false

func _ready() -> void:
	Global.GameOver = self
	death_reason_label.text = tr("You died of ")

func init(reason):
	var day = str(Global.Date.getDay())
	var time = Global.timeGetFullFormat(Global.Date.getTime(),true,true)
	time_lived_label.text = tr("Survived") + "\n " + day + tr("Days") + "\n" + time
	death_reason_label.text += get_reason(reason) + " "
	if not recordAdded:
		ServiceManager.add_highscore(Global.Date.getTotalTime(),Difficulty.current)
		var record = Save.saveRecord(Global.Date.getTotalTime())
		var best = LeaderBoard.getBestTime(record)
		if best != null:
			day = str(floor(best/1440))
			time = Global.timeGetFullFormat(fmod(best,1440),true,true)
			record_lived_label.text = tr("Record") + "\n " + day + tr("Days") + "\n" + time
		else:
			record_lived_label.text = "error loading records"
		recordAdded = true
	show()
	Global.Sound.play(Sound.UI_DEATH, "SFX")

func get_reason(reason : int):
	var text
	match reason:
		reasons.Water:
			text = "dehydration"
		reasons.Food:
			text = "hunger"
		reasons.Sick:
			text = "illnes"
		reasons.Energy:
			text = "insomnia"
		reasons.Combat:
			text = "combat"
	return tr(text)

func _on_NewGameButton_pressed() -> void:
	Save.newGame()
	hide()
