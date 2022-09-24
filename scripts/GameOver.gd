extends Control

onready var time_lived_label: Label = $VBoxContainer/TimeLivedLabel

func _ready() -> void:
	Global.GameOver = self

func init():
	var day = str(Global.Date.getDay())
	var time = Global.timeGetFullFormat(Global.Date.getTime(),true,true)
	time_lived_label.text = "You survived\n" + day + "D " + time
	show()

func _on_NewGameButton_pressed() -> void:
	Save.newGame()
	hide()
