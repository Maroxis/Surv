extends Control

class_name GameOver

onready var time_lived_label: Label = $VBoxContainer/TimeLivedLabel
onready var death_reason_label: Label = $VBoxContainer/DeathReasonLabel
enum reasons {Water, Food, Energy, Sick}

func _ready() -> void:
	Global.GameOver = self
	death_reason_label.text = "You died of "

func init(reason):
	var day = str(Global.Date.getDay())
	var time = Global.timeGetFullFormat(Global.Date.getTime(),true,true)
	time_lived_label.text = "Survived\n" + day + "D " + time
	death_reason_label.text += get_reason(reason) + " "
	show()

func get_reason(reason : int):
	match reason:
		reasons.Water:
			return "dehydration"
		reasons.Food:
			return "hunger"
		reasons.Sick:
			return "illnes"
		reasons.Energy:
			return "insomnia"

func _on_NewGameButton_pressed() -> void:
	Save.newGame()
	hide()
